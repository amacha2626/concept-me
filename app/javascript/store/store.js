import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    signedIn: '', 
    user_email: ''
  },
  mutations: {
    fetchSignedIn(state) {
      state.signedIn = !!localStorage.signedIn
    },
    deleteEmail(state){
      state.user_email = ''
    }
  },
  actions: {
    doFetchSignedIn({ commit }) {
      commit('fetchSignedIn')
    },
    doDeleteEmail({ commit }) {
      commit('deleteEmail')
    }
  },
  plugins: [createPersistedState()],
})