import request from '@/utils/request'
// 查询服务器分组列表
export function listVpnServerGroup(query) {
  return request({
    url: '/vpn/vpnServerGroup/list',
    method: 'get',
    params: query
  })
}
// 查询服务器分组详细
export function getVpnServerGroup(serverGroupId) {
  return request({
    url: '/vpn/vpnServerGroup/get',
    method: 'get',
    params: {
     id: serverGroupId.toString()
    }
  })
}
// 新增服务器分组
export function addVpnServerGroup(data) {
  return request({
    url: '/vpn/vpnServerGroup/add',
    method: 'post',
    data: data
  })
}
// 修改服务器分组
export function updateVpnServerGroup(data) {
  return request({
    url: '/vpn/vpnServerGroup/edit',
    method: 'put',
    data: data
  })
}
// 删除服务器分组
export function delVpnServerGroup(serverGroupIds) {
  return request({
    url: '/vpn/vpnServerGroup/delete',
    method: 'delete',
    data:{
       ids:serverGroupIds
    }
  })
}
