import request from '@/utils/request'
// 查询节点分组列表
export function listVpnNodeGroup(query) {
  return request({
    url: '/vpn/vpnNodeGroup/list',
    method: 'get',
    params: query
  })
}
// 查询节点分组详细
export function getVpnNodeGroup(nodeGroupId) {
  return request({
    url: '/vpn/vpnNodeGroup/get',
    method: 'get',
    params: {
     id: nodeGroupId.toString()
    }
  })
}
// 新增节点分组
export function addVpnNodeGroup(data) {
  return request({
    url: '/vpn/vpnNodeGroup/add',
    method: 'post',
    data: data
  })
}
// 修改节点分组
export function updateVpnNodeGroup(data) {
  return request({
    url: '/vpn/vpnNodeGroup/edit',
    method: 'put',
    data: data
  })
}
// 删除节点分组
export function delVpnNodeGroup(nodeGroupIds) {
  return request({
    url: '/vpn/vpnNodeGroup/delete',
    method: 'delete',
    data:{
       ids:nodeGroupIds
    }
  })
}
