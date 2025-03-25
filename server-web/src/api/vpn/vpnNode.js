import request from '@/utils/request'
// 查询Vpn节点配置列表
export function listVpnNode(query) {
  return request({
    url: '/vpn/vpnNode/list',
    method: 'get',
    params: query
  })
}
// 查询Vpn节点配置详细
export function getVpnNode(nodeId) {
  return request({
    url: '/vpn/vpnNode/get',
    method: 'get',
    params: {
     id: nodeId.toString()
    }
  })
}
// 新增Vpn节点配置
export function addVpnNode(data) {
  return request({
    url: '/vpn/vpnNode/add',
    method: 'post',
    data: data
  })
}
// 修改Vpn节点配置
export function updateVpnNode(data) {
  return request({
    url: '/vpn/vpnNode/edit',
    method: 'put',
    data: data
  })
}

export function updateVpnNodes(data) {
  return request({
    url: '/vpn/vpnNode/edits',
    method: 'put',
    data: data
  })
}

// 删除Vpn节点配置
export function delVpnNode(nodeIds) {
  return request({
    url: '/vpn/vpnNode/delete',
    method: 'delete',
    data:{
       ids:nodeIds
    }
  })
}




export function speedTest(nodeId,pingId){
  return request({
    url: '/vpn/vpnNode/speedTest',
    method: 'get',
    params: {
      id:nodeId,
      pingId:pingId
    }
  })
}


export function pingTest(nodeId,pingId){
  return request({
    url: '/vpn/vpnNode/pingTest',
    method: 'get',
    params: {
      id:nodeId,
      pingId:pingId
    }
  })
}
