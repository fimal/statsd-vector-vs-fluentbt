import http from "k6/http";
var url = `http://${__ENV.MY_HOST}`;
var params = {
    headers: {
      'Host': `${__ENV.CASE}.${__ENV.DOMAIN}`,
      'xff': `${__ENV.USER_IP}`,
      'Accept': 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg',
      'Accept-Language': 'en-us',
      'Accept-Encoding': 'gzip, deflate, compress',
    },
    timeout: "300s", // Important to show that request is stuck
  };
  export let options = {
    summaryTimeUnit: 'ms',
    scenarios: {
      constant_request_rate: {
          executor: 'constant-arrival-rate',
          rate: `${__ENV.RATE}`,
          timeUnit: '1s',
          duration: `${__ENV.DURATION}`,
          preAllocatedVUs: 100, // how large the initial pool of VUs would be
          maxVUs: 1000, // if the preAllocatedVUs are not enough, we can initialize more
          gracefulStop: '330s', // Don't kill requests too early, otherwise k6 will not catch issue
      },
    },
  };
export default function() {
    http.get(url, params);
};
export function handleSummary(data) {
  return {
    'stdout': JSON.stringify(data)
  }
};