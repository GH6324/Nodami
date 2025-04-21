export function connectWebSocket(url, callbacks = {}) {
  const ws = new WebSocket(`wss://your-domain.com${url}`) // 根据实际环境调整

  const defaultCallbacks = {
    onOpen: () => console.log('WebSocket连接成功'),
    onMessage: () => {},
    onError: () => {},
    onClose: () => {}
  }

  const { onOpen, onMessage, onError, onClose } = { ...defaultCallbacks, ...callbacks }

  ws.onopen = onOpen

  ws.onmessage = (event) => {
    try {
      const data = JSON.parse(event.data)
      onMessage(data)
    } catch (e) {
      console.error('消息解析失败:', e)
    }
  }

  ws.onerror = (error) => {
    onError(error)
    // 可添加重连逻辑
  }

  ws.onclose = (event) => {
    onClose(event)
    // 可添加重连逻辑
  }

  return {
    close: () => ws.close(),
    send: (data) => ws.send(JSON.stringify(data))
  }
}
