
import Vue    from 'vue'
import App    from './App.vue'
import Router from '../router/router.js'
import Store  from '../store/store.js'
import VueAxios from 'vue-axios'
import Vmodal from 'vue-js-modal'
import { securedAxiosInstance, plainAxiosInstance } from '../backend/axios/axios.js'

Vue.config.productionTip = false
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})
Vue.use(Vmodal)

const app = new Vue({
   el: '#app',
   router: Router,
   store: Store,
   securedAxiosInstance,
   plainAxiosInstance,
   render: h => h(App)
})