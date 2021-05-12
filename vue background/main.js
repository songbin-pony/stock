// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import qs from 'qs'
import CKEditor from '@ckeditor/ckeditor5-build-decoupled-document'
import '@ckeditor/ckeditor5-build-decoupled-document/build/translations/zh-cn.js'
Vue.config.productionTip = false;

/* eslint-disable no-new */
Vue.use(ElementUI);
Vue.prototype.$qs = qs;
Vue.prototype.$CKEditor=CKEditor;
Vue.prototype.$http=axios;
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
