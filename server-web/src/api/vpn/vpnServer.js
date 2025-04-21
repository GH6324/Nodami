import request from '@/utils/request'

// 查询Vpn服务器列表
export function listVpnServer(query) {
  return request({
    url: '/vpn/vpnServer/list',
    method: 'get',
    params: query
  })
}

// 查询Vpn服务器详细
export function getVpnServer(serverId) {
  return request({
    url: '/vpn/vpnServer/get',
    method: 'get',
    params: {
      id: serverId.toString()
    }
  })
}

// 新增Vpn服务器
export function addVpnServer(data) {
  return request({
    url: '/vpn/vpnServer/add',
    method: 'post',
    data: data
  })
}

// 修改Vpn服务器
export function updateVpnServer(data) {
  return request({
    url: '/vpn/vpnServer/edit',
    method: 'put',
    data: data
  })
}

export function updateVpnServers(data) {
  return request({
    url: '/vpn/vpnServer/edits',
    method: 'put',
    data: data
  })
}

// 删除Vpn服务器
export function delVpnServer(serverIds) {
  return request({
    url: '/vpn/vpnServer/delete',
    method: 'delete',
    data: {
      ids: serverIds
    }
  })
}

// 关联vpn_node_nation表选项
export function listVpnNodeNation(query) {
  return request({
    url: '/vpn/vpnNodeNation/list',
    method: 'get',
    params: query
  })
}


export function reStartServer(serverIds) {
  return request({
    url: '/vpn/vpnServer/reStartServer',
    method: 'post',
    data: {
      ids: serverIds
    }
  })
}

export function reStartVpnServer(serverIds) {
  return request({
    url: '/vpn/vpnServer/reStartVpnServer',
    method: 'post',
    data: {
      ids: serverIds
    }
  })
}

export function pppoeReStart(serverIds) {
  return request({
    url: '/vpn/vpnServer/pppoeReStart',
    method: 'post',
    data: {
      ids: serverIds
    }
  })
}




export function log(serverId,logName) {
  return request({
    url: '/vpn/vpnServer/log',
    method: 'post',
    data: {
      serverId: serverId,
      logName: logName,
    }
  })
}

export function info(serverId) {
  return request({
    url: '/vpn/vpnServer/info',
    method: 'post',
    data: {
      serverId: serverId
    }
  })
}


export function pingServer(inServerId,toServerId) {
  return request({
    url: '/vpn/vpnServer/pingServer',
    method: 'post',
    data: {
      inServerId: inServerId,
      toServerId: toServerId,
    }
  })
}
