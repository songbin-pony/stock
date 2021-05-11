// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import * as echarts from 'echarts'
import Print from 'vue-print-nb'
import qs from 'qs'
import moment from 'moment'
Vue.use(Print);
Vue.use(echarts);
Vue.prototype.$echarts = echarts;
Vue.prototype.$qs = qs;
Vue.config.productionTip = false;
/* eslint-disable no-new */
Vue.use(ElementUI);
Vue.prototype.$http=axios;
Vue.prototype.$moment = moment;
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
