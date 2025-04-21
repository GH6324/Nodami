package controller

import (
	"fmt"
	"gfast/app/common/api"
	"gfast/app/terminal/core"
	"github.com/gogf/gf/net/ghttp"
	"io"
	"net/http"
	"sort"
	"strconv"
	"strings"
	"time"
)

// File 结构体
type File struct {
	Name       string
	Size       string
	ModifyTime string
	IsDir      bool
}

const (
	// BYTE 字节
	BYTE = 1 << (10 * iota)
	// KILOBYTE 千字节
	KILOBYTE
	// MEGABYTE 兆字节
	MEGABYTE
	// GIGABYTE 吉字节
	GIGABYTE
	// TERABYTE 太字节
	TERABYTE
	// PETABYTE 拍字节
	PETABYTE
	// EXABYTE 艾字节
	EXABYTE
)

// Bytefmt returns a human-readable byte string of the form 10M, 12.5K, and so forth.  The following units are available:
//
//	E: Exabyte
//	P: Petabyte
//	T: Terabyte
//	G: Gigabyte
//	M: Megabyte
//	K: Kilobyte
//	B: Byte
//
// The unit that results in the smallest number greater than or equal to 1 is always chosen.
func Bytefmt(bytes uint64) string {
	unit := ""
	value := float64(bytes)

	switch {
	case bytes >= EXABYTE:
		unit = "E"
		value = value / EXABYTE
	case bytes >= PETABYTE:
		unit = "P"
		value = value / PETABYTE
	case bytes >= TERABYTE:
		unit = "T"
		value = value / TERABYTE
	case bytes >= GIGABYTE:
		unit = "G"
		value = value / GIGABYTE
	case bytes >= MEGABYTE:
		unit = "M"
		value = value / MEGABYTE
	case bytes >= KILOBYTE:
		unit = "K"
		value = value / KILOBYTE
	case bytes >= BYTE:
		unit = "B"
	case bytes == 0:
		return "0B"
	}

	result := strconv.FormatFloat(value, 'f', 2, 64)
	result = strings.TrimSuffix(result, ".00")
	return result + unit
}

type fileSplice []File

// Len 比较大小
func (f fileSplice) Len() int { return len(f) }

// Swap 交换
func (f fileSplice) Swap(i, j int) { f[i], f[j] = f[j], f[i] }

// Less 比大小
func (f fileSplice) Less(i, j int) bool { return f[i].IsDir }

type terminalFile struct {
	api.CommonBase
}

var TerminalFile = new(terminalFile)

// UploadFile 上传文件
func (s *terminalFile) UploadFile(c *ghttp.Request) {
	var (
		sshClient core.SSHClient
		err       error
	)

	serverId := c.GetInt("serverId")
	id := c.GetString("id")
	if sshClient, err = core.DecodedMsgToSSHClient(serverId); err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	if err = sshClient.CreateSftp(); err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	defer sshClient.Close()
	file, header, err := c.Request.FormFile("file")
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	defer file.Close()
	path := strings.TrimSpace(c.GetString("path", "/root"))
	pathArr := []string{strings.TrimRight(path, "/")}
	if dir := c.GetString("dir", ""); "" != dir {
		pathArr = append(pathArr, dir)
		if err = sshClient.Mkdirs(strings.Join(pathArr, "/")); err != nil {
			s.FailJsonExit(c, err.Error())
			return
		}
	}
	pathArr = append(pathArr, header.Filename)
	err = sshClient.Upload(file, id, strings.Join(pathArr, "/"))
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	s.SusJsonExit(c, nil)
}

// DownloadFile 下载文件
func (s *terminalFile) DownloadFile(c *ghttp.Request) {
	var (
		sshClient core.SSHClient
		err       error
	)

	path := strings.TrimSpace(c.GetString("path", "/root"))
	serverId := c.GetInt("serverId")
	if sshClient, err = core.DecodedMsgToSSHClient(serverId); err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	if err = sshClient.CreateSftp(); err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	defer sshClient.Close()
	if sftpFile, err := sshClient.Download(path); err != nil {
		s.FailJsonExit(c, err.Error())
		return
	} else {
		defer sftpFile.Close()
		c.Response.Writer.WriteHeader(http.StatusOK)
		fileMeta := strings.Split(path, "/")
		c.Response.Header().Set("Content-Disposition", "attachment; filename="+fileMeta[len(fileMeta)-1])
		_, err = io.Copy(c.Response.Writer, sftpFile)
		if err != nil {
			s.FailJsonExit(c, err.Error())
			return
		}
	}
	c.Exit()
}

// UploadProgressWs 获取上传进度ws
func (s *terminalFile) UploadProgressWs(c *ghttp.Request) {
	wsConn, err := upgrader.Upgrade(c.Response.Writer, c.Request, nil)
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	id := c.GetString("id")

	var ready, find bool
	for {
		if !ready && core.WcList == nil {
			continue
		}
		for _, v := range core.WcList {
			if v.Id == id {
				wsConn.WriteMessage(1, []byte(strconv.Itoa(v.Total)))
				find = true
				if !ready {
					ready = true
				}
				break
			}
		}
		if ready && !find {
			wsConn.Close()
			break
		}

		if ready {
			time.Sleep(300 * time.Millisecond)
			find = false
		}
	}
	c.Exit()
}

// FileList 获取文件列表
func (s *terminalFile) FileList(c *ghttp.Request) {

	path := c.GetString("path", "/root")
	serverId := c.GetInt("serverId")
	sshClient, err := core.DecodedMsgToSSHClient(serverId)
	if err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	if err = sshClient.CreateSftp(); err != nil {
		s.FailJsonExit(c, err.Error())
		return
	}
	defer sshClient.Close()
	files, err := sshClient.Sftp.ReadDir(path)
	if err != nil {
		if strings.Contains(err.Error(), "exist") {
			err = fmt.Errorf("Directory %s: no such file or directory", path)
		}
		s.FailJsonExit(c, err.Error())
		return
	}
	var (
		fileList fileSplice
		fileSize string
	)
	for _, mFile := range files {
		if mFile.IsDir() {
			fileSize = strconv.FormatInt(mFile.Size(), 10)
		} else {
			fileSize = Bytefmt(uint64(mFile.Size()))
		}
		file := File{Name: mFile.Name(), IsDir: mFile.IsDir(), Size: fileSize, ModifyTime: mFile.ModTime().Format("2006-01-02 15:04:05")}
		fileList = append(fileList, file)
	}
	sort.Stable(fileList)
	s.SusJsonExit(c, map[string]interface{}{
		"path": path,
		"list": fileList,
	})
}
