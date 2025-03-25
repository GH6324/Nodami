import request from '@/utils/request'

export function getDashboardInfo() {
  return request({
    url: '/system/dashboard/info',
    method: 'get',
  })
}


export function getDashboardChart() {
  return request({
    url: '/system/dashboard/chart',
    method: 'get',
  })
}
