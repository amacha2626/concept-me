import Vue          from 'vue'
import VueRouter    from 'vue-router'
import SignInTop    from '../pages/SignInTop'
import SignOutTop   from '../pages/SignOutTop'
import Posts        from '../components/Posts'
import UserInfo     from '../components/UserInfo'
import store        from '../store/store.js'


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: SignInTop,
      beforeEnter(to, from, next){
        if (store.state.signedIn){
          next();
        } else {
          next('/home')
        }
      },
      children: [
        {
          path: '/',
          component: Posts,
          beforeEnter(to, from, next){
            if (store.state.signedIn){
              next();
            } else {
              next('/home')
            }
          }
        },
        {
          name: 'user',
          path: '/user/:id',
          component: UserInfo,
          beforeEnter(to, from, next){
            if (store.state.signedIn){
              next();
            } else {
              next('/home')
            }
          }
        }
      ]
    },
    {
      path: '/home',
      component: SignOutTop,
      beforeEnter(to, from, next){
        if (!localStorage.signedIn){
          next();
        } else {
          next('/contents')
        }
      }
    },
  ],
});