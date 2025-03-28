import request from '@/utils/request'
// 查询订阅管理列表
export function listVpnSubscription(query) {
  return request({
    url: '/vpn/vpnSubscription/list',
    method: 'get',
    params: query
  })
}
// 查询订阅管理详细
export function getVpnSubscription(subscriptionId) {
  return request({
    url: '/vpn/vpnSubscription/get',
    method: 'get',
    params: {
     id: subscriptionId.toString()
    }
  })
}
// 新增订阅管理
export function addVpnSubscription(data) {
  return request({
    url: '/vpn/vpnSubscription/add',
    method: 'post',
    data: data
  })
}
// 修改订阅管理
export function updateVpnSubscription(data) {
  return request({
    url: '/vpn/vpnSubscription/edit',
    method: 'put',
    data: data
  })
}
// 删除订阅管理
export function delVpnSubscription(subscriptionIds) {
  return request({
    url: '/vpn/vpnSubscription/delete',
    method: 'delete',
    data:{
       ids:subscriptionIds
    }
  })
}
