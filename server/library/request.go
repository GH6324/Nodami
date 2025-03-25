package library

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"

	"github.com/gogf/gf/net/ghttp"
)

type ContentType string

const ContentJson = ContentType("application/json")
const ContentForm = ContentType("application/x-www-form-urlencoded")

func ParseForm(r *ghttp.Request) (map[string]interface{}, error) {
	body, err := r.Request.GetBody()
	if err != nil {
		return nil, err
	}
	defer body.Close()

	byteData, err := io.ReadAll(body)
	if err != nil {
		return nil, err
	}

	paramsMap := make(map[string]interface{})

	err = json.Unmarshal(byteData, &paramsMap)
	if err != nil {
		return nil, err
	}

	return paramsMap, nil
}

func ParseJson(r *ghttp.Request) (map[string]interface{}, error) {
	body := r.Request.Body
	defer body.Close()

	byteData, err := io.ReadAll(body)
	if err != nil {
		return nil, err
	}

	paramsMap := make(map[string]interface{})

	err = json.Unmarshal(byteData, &paramsMap)
	if err != nil {
		return nil, err
	}

	return paramsMap, nil
}

func ParseQuery(r *ghttp.Request) (map[string]interface{}, error) {
	queryValues := r.URL.Query()
	// 将查询参数转换为map
	paramsMap := make(map[string]interface{})
	for key, values := range queryValues {
		paramsMap[key] = values[0]
	}
	return paramsMap, nil
}

// 发送GET请求
func HttpUrl(urlStr string, params map[string]interface{}) (string, error) {
	// 构建URL
	u, err := url.Parse(urlStr)
	if err != nil {
		return "", err
	}

	// 添加查询参数
	q := u.Query()
	for key, value := range params {
		q.Set(key, fmt.Sprint(value))
	}
	u.RawQuery = q.Encode()

	url := u.String()

	return url, nil
}

// 发送GET请求
func HttpGet(urlStr string, params map[string]string) ([]byte, error) {
	// 构建URL
	u, err := url.Parse(urlStr)
	if err != nil {
		return nil, err
	}

	// 添加查询参数
	q := u.Query()
	for key, value := range params {
		q.Set(key, fmt.Sprint(value))
	}
	u.RawQuery = q.Encode()

	url := u.String()
	// 发送请求
	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	// 读取响应
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	return body, nil
}

// HttpPost 发送POST请求
func HttpPost(urlStr string, data interface{}, contentType ContentType) (statusCode int, body []byte, err error) {
	var buffer bytes.Buffer

	// 根据内容类型处理数据
	if contentType == "application/json" {
		// JSON数据
		err = json.NewEncoder(&buffer).Encode(data)
		if err != nil {
			return
		}
	} else if contentType == "application/x-www-form-urlencoded" {
		// 表单数据
		formValues := url.Values{}
		for key, value := range data.(map[string]interface{}) {
			formValues.Set(key, fmt.Sprint(value))
		}
		buffer.WriteString(formValues.Encode())
	} else {
		return
	}

	// 发送请求
	resp, err := http.Post(urlStr, string(contentType), &buffer)
	if err != nil {
		return
	}
	defer resp.Body.Close()

	statusCode = resp.StatusCode

	// 读取响应
	body, err = io.ReadAll(resp.Body)
	if err != nil {
		return
	}

	return
}
