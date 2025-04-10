import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import '@/assets/css/global.css'
import '@/assets/css/theme/index.css'
import request from "@/utils/request";
import echarts from 'echarts'
import store  from "./store/index.js";
import "./router/permission"

Vue.config.productionTip = false

Vue.prototype.$request = request
Vue.prototype.$baseUrl = process.env.VUE_APP_BASEURL
Vue.prototype.$echarts = echarts;

Vue.use(ElementUI, {size: "small"})

new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app')
