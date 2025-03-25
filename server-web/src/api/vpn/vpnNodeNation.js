import request from '@/utils/request'
// 查询vpn ip 地区
export function listVpnNodeNation(query) {
  return request({
    url: '/vpn/vpnNodeNation/list',
    method: 'get',
    params: query
  })
}
// 查询vpn ip 地区
export function getVpnNodeNation(nationId) {
  return request({
    url: '/vpn/vpnNodeNation/get',
    method: 'get',
    params: {
     id: nationId.toString()
    }
  })
}
// 新增vpn ip 地区
export function addVpnNodeNation(data) {
  return request({
    url: '/vpn/vpnNodeNation/add',
    method: 'post',
    data: data
  })
}
// 修改vpn ip 地区
export function updateVpnNodeNation(data) {
  return request({
    url: '/vpn/vpnNodeNation/edit',
    method: 'put',
    data: data
  })
}
// 删除vpn ip 地区
export function delVpnNodeNation(nationIds) {
  return request({
    url: '/vpn/vpnNodeNation/delete',
    method: 'delete',
    data:{
       ids:nationIds
    }
  })
}
