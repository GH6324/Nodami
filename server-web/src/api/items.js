// 查询列表
export function getItems(f, query) {
  query = query || { pageSize: 10000 }
  return f(query)
}

export function setItems(response, k, v) {
  const data = []
  k = k || 'id'
  v = v || 'name'
  if (response.data && response.data.list && response.data.list.length > 0) {
    response.data.list.forEach(e => {
      data.push({
        key: e[k].toString(),
        value: e[v].toString(),
        source: e,
      })
    })
    return data
  }
}

function sprintf(format, ...args) {
  let i = 0;
  return format.replace(/%s/g, () => args[i++]);
}
export function setXiaoBaiItems(response, k,sprintf,...v) {
  const data = []
  k = k || 'id'
  v = v || ['name']
  if (response.data && response.data.list && response.data.list.length > 0) {
    response.data.list.forEach(e => {
      let value = [];
      for (const item of v) {
        value.push(e[item].toString())
      }
      data.push({
        key: e[k].toString(),
        value: sprintf(sprintf,value)
      })
    })
  }
  return data
}
