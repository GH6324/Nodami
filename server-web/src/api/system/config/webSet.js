import request from '@/utils/request'

// 查询站点信息

export function getInfo() {
  const cacheKey = 'sysWebSetCache';
  const cachedData = localStorage.getItem(cacheKey);

  if (cachedData) {
    // 返回缓存数据
    return Promise.resolve(JSON.parse(cachedData));
  }

  // 如果没有缓存，则从接口获取
  return request({
    url: '/system/config/sysWebSet',
    method: 'get'
  }).then(response => {
    // 获取数据后缓存到localStorage
    localStorage.setItem(cacheKey, JSON.stringify(response));
    return response;
  });
}

// 更新站点信息，并清除缓存
export function updateInfo(data) {
  const cacheKey = 'sysWebSetCache';

  return request({
    url: '/system/config/sysWebSet/update',
    method: 'post',
    data: { webId: data.webId, webContent: data }
  }).then(response => {
    // 更新成功后清除缓存
    localStorage.removeItem(cacheKey);
    return response;
  });
}
