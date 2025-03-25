import request from '@/utils/request'
// 查询测速配置列表
export function listVpnNodePing(query) {
  return request({
    url: '/vpn/vpnNodePing/list',
    method: 'get',
    params: query
  })
}
// 查询测速配置详细
export function getVpnNodePing(pingId) {
  return request({
    url: '/vpn/vpnNodePing/get',
    method: 'get',
    params: {
     id: pingId.toString()
    }
  })
}
// 新增测速配置
export function addVpnNodePing(data) {
  return request({
    url: '/vpn/vpnNodePing/add',
    method: 'post',
    data: data
  })
}
// 修改测速配置
export function updateVpnNodePing(data) {
  return request({
    url: '/vpn/vpnNodePing/edit',
    method: 'put',
    data: data
  })
}
// 删除测速配置
export function delVpnNodePing(pingIds) {
  return request({
    url: '/vpn/vpnNodePing/delete',
    method: 'delete',
    data:{
       ids:pingIds
    }
  })
}
// 关联vpn_server表选项
export function listVpnServer(query){
   return request({
     url: '/vpn/vpnServer/list',
     method: 'get',
     params: query
   })
}
