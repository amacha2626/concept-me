import Vue          from 'vue'
import VueRouter    from 'vue-router'
import Signup       from '../pages/Signup.vue'
import Signin       from '../pages/Signin.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/signup',    name: 'Signup',      component: Signup },
  { path: '/signin',    name: 'Signin',      component: Signin }
];

export default new VueRouter({ routes });