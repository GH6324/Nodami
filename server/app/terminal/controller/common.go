package controller

//func CheckSSH(c *ghttp.Request) *ResponseBody {
//	responseBody := ResponseBody{Msg: "success"}
//	defer TimeCost(time.Now(), &responseBody)
//	sshInfo := c.GetString("sshInfo", "")
//	sshClient, err := core.DecodedMsgToSSHClient(sshInfo)
//	if err != nil {
//		fmt.Println(err)
//		responseBody.Msg = err.Error()
//		return &responseBody
//	}
//
//	err = sshClient.GenerateClient()
//	defer sshClient.Close()
//
//	if err != nil {
//		fmt.Println(err)
//		responseBody.Msg = err.Error()
//	}
//	return &responseBody
//}
