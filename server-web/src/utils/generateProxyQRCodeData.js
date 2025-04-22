// generateProxyQRCodeData.js  (rev‑4 – ES6‑only)
// ---------------------------------------------------------------------------
// Converts a Clash‑style proxy node to a QR‑import string for tools such as
// Shadowrocket, ClashMeta, V2RayN …
/*─────────────────────────────────────────────────────────────────────────────*
 *  Utilities
 *────────────────────────────────────────────────────────────────────────────*/
const b64 = (str, urlSafe) => {
  const enc = (typeof btoa === 'function')
    ? btoa(unescape(encodeURIComponent(str)))
    : Buffer.from(str, 'utf8').toString('base64');
  return urlSafe ? enc.replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_') : enc;
};

function pick(obj, camelKey) {
  if (!obj || typeof obj !== 'object') return undefined;
  var kebab  = camelKey.replace(/([A-Z])/g, (_, m) => '-' + m.toLowerCase());
  var snake  = camelKey.replace(/([A-Z])/g, (_, m) => '_' + m.toLowerCase());
  var pascal = camelKey.charAt(0).toUpperCase() + camelKey.slice(1);
  var keys   = [camelKey, kebab, snake, pascal];
  for (var i = 0; i < keys.length; i++) if (obj.hasOwnProperty(keys[i])) return obj[keys[i]];
  return undefined;
}
function bool(v) { return v === true || v === 'true' || v === 1 || v === '1'; }
function dig(obj /*, k1, k2, … */) {
  var res = obj;
  for (var i = 1; i < arguments.length; i++) {
    if (res == null) return undefined;
    res = res[arguments[i]];
  }
  return res;
}

function wrapIPv6(host) {
  if (typeof host !== 'string') return host;
  return host.includes(':') && !host.startsWith('[') ? `[${host}]` : host;
}

/*─────────────────────────────────────────────────────────────────────────────*
 *  Main Converter
 *────────────────────────────────────────────────────────────────────────────*/
export function  generateProxyQRCodeData(proxy) {
  console.log(proxy)
  if (!proxy || typeof proxy !== 'object') throw new Error('proxy must be an object');

  var type   = String(pick(proxy, 'type') || '').toLowerCase();
  var name   = encodeURIComponent(pick(proxy, 'name') || 'node');
  var server = wrapIPv6(pick(proxy, 'server'));
  var port   = pick(proxy, 'port');

  var net  = String(pick(proxy, 'network') || '').toLowerCase();
  var tls  = bool(pick(proxy, 'tls'));
  var insecure = bool(pick(proxy, 'skipCertVerify')) ||
    bool(pick(proxy, 'skip-cert-verify')) ||
    bool(pick(proxy, 'allowInsecure'))   ||
    bool(pick(proxy, 'allow_insecure'));
  var sni  = pick(proxy, 'sni') || pick(proxy, 'serverName') || pick(proxy, 'servername');
  var fp   = pick(proxy, 'clientFingerprint') || pick(proxy, 'fingerprint');
  var alpn = pick(proxy, 'alpn') || [];

  var ws      = pick(proxy, 'wsOpts');
  var grpc    = pick(proxy, 'grpcOpts');
  var reality = pick(proxy, 'realityOpts');
  var plugin  = pick(proxy, 'plugin');
  var pluginOpts = pick(proxy, 'pluginOpts');



  /* ---------------- Shadowsocks ---------------- */
  if (type === 'ss') {
    var cipher = pick(proxy, 'cipher');
    var pass   = pick(proxy, 'password');
    if (!cipher || !pass) throw new Error('ss node missing cipher/password');
    var userInfo = b64(cipher + ':' + pass);
    var url = 'ss://' + userInfo + '@' + server + ':' + port;
    if (plugin) {
      var qs = [];
      var po = 'plugin=' + encodeURIComponent(plugin);
      if (pluginOpts) {
        var extras = Object.keys(pluginOpts).map(k => k + '=' + pluginOpts[k]).join(';');
        if (extras) po += ';' + extras;
      }
      qs.push(po);
      url += '?' + qs.join('&');
    }
    return url + '#' + name;
  }

  /* ---------------- VMESS ---------------- */
  if (type === 'vmess') {
    var serviceName = dig(grpc, 'grpc-service-name') ||
      dig(grpc, 'GrpcServiceName')    ||
      dig(grpc, 'grpcServiceName')    || '';
    var json = {
      v: '2',
      ps: decodeURIComponent(name),
      add: server,
      port: String(port),
      id: pick(proxy, 'uuid'),
      aid: String(pick(proxy, 'alterId') || 0),
      scy: pick(proxy, 'cipher') || 'auto',
      net: net,
      type: '',
      host: dig(ws, 'headers', 'Host') || dig(ws, 'Headers', 'Host') || sni || '',
      path: dig(ws, 'path') || dig(ws, 'Path') || '',
      tls:  tls ? 'tls' : '',
      sni:  sni || '',
      fp:   fp || '',
      alpn: Array.isArray(alpn) ? alpn.join(',') : alpn,
      serviceName: serviceName,
      allowInsecure: insecure ? '1' : '0'
    };
    return 'vmess://' + b64(JSON.stringify(json), true);
  }

  /* ---------------- VLESS ---------------- */
  if (type === 'vless') {
    var q = [];
    q.push('encryption=none');
    if (tls) q.push('security=' + (reality ? 'reality' : 'tls'));
    if (insecure) q.push('allowInsecure=1');
    if (net) q.push('type=' + net);
    if (ws) {
      if (dig(ws, 'path')) q.push('path=' + encodeURIComponent(dig(ws, 'path')));
      var hostH = dig(ws, 'headers', 'Host') || dig(ws, 'Headers', 'Host');
      if (hostH) q.push('host=' + hostH);
    }
    var svc = dig(grpc, 'grpc-service-name');
    if (svc) q.push('serviceName=' + svc);
    if (sni) q.push('sni=' + sni);
    if (fp) q.push('fp=' + fp);
    if (alpn && alpn.length) q.push('alpn=' + alpn.join(','));
    if (reality) {
      if (reality.publicKey) q.push('pbk=' + reality.publicKey);
      if (reality.shortId)  q.push('sid=' + reality.shortId);
    }
    return 'vless://' + pick(proxy, 'uuid') + '@' + server + ':' + port + '?' + q.join('&') + '#' + decodeURIComponent(name);
  }

  /* ---------------- TROJAN ---------------- */
  if (type === 'trojan') {
    var q2 = [];
    if (tls) q2.push('security=' + (reality ? 'reality' : 'tls'));
    if (insecure) q2.push('allowInsecure=1');
    if (net) q2.push('type=' + net);
    if (ws) {
      if (dig(ws, 'path')) q2.push('path=' + encodeURIComponent(dig(ws, 'path')));
      var host2 = dig(ws, 'headers', 'Host') || dig(ws, 'Headers', 'Host');
      if (host2) q2.push('host=' + host2);
    }
    var svc2 = dig(grpc, 'grpc-service-name');
    if (svc2) q2.push('serviceName=' + svc2);
    if (sni) q2.push('sni=' + sni);
    if (fp)  q2.push('fp=' + fp);
    if (alpn && alpn.length) q2.push('alpn=' + alpn.join(','));
    if (reality) {
      if (reality.publicKey) q2.push('pbk=' + reality.publicKey);
      if (reality.shortId)  q2.push('sid=' + reality.shortId);
    }
    return 'trojan://' + pick(proxy, 'password') + '@' + server + ':' + port + '?' + q2.join('&') + '#' + decodeURIComponent(name);
  }

  /* ---------------- Hysteria2 ---------------- */
  if (type === 'hysteria2') {
    var q3 = [];
    if (sni) q3.push('sni=' + sni);
    q3.push('insecure=' + (insecure ? '1' : '0'));
    if (alpn && alpn.length) q3.push('alpn=' + alpn.join(','));
    return 'hy2://' + pick(proxy, 'password') + '@' + server + ':' + port + '?' + q3.join('&') + '#' + name;
  }

  /* ---------------- TUIC ---------------- */
  if (type === 'tuic') {
    var q4 = [];
    var cc = pick(proxy, 'congestionController');
    if (cc) q4.push('congestion_control=' + cc);
    if (alpn && alpn.length) q4.push('alpn=' + alpn.join(','));
    q4.push('allow_insecure=' + (insecure ? '1' : '0'));
    if (sni) q4.push('sni=' + sni);
    return 'tuic://' + pick(proxy, 'uuid') + ':' + pick(proxy, 'password') + '@' + server + ':' + port + '?' + q4.join('&') + '#' + name;
  }

  /* ---------------- SOCKS5 ---------------- */
  if (type === 'socks5') {
    var user = pick(proxy, 'userName') || pick(proxy, 'username');
    var passS = pick(proxy, 'password') || '';
    var auth = user ? encodeURIComponent(user) + ':' + encodeURIComponent(passS) + '@' : '';
    return 'socks5://' + auth + server + ':' + port + '#' + name;
  }

  throw new Error('Unsupported protocol type: ' + type);
}

