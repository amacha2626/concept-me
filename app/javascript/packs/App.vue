<template>
  <div id="app">
    <router-link to="/signup" v-if="!signedIn">Sign up</router-link>
    <router-link to="/signin" v-if="!signedIn">Sign in</router-link>
    <a href="/" v-if="signedIn" @click="signOut">Sign out</a>
    <router-view></router-view>
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: mapState([
      'signedIn'
    ]),
    mounted: function() {
      this.$store.dispatch('doFetchSignedIn')
    },
    methods: {
      setError(error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      signOut() {
        this.$http.secured.delete(`/api/signin`)
          .then(response => {
            delete localStorage.csrf
            delete localStorage.signedIn
          })
          .catch(error => this.setError(error, 'Cannot sign out'))
      }
    }
  }
</script>

<style scoped>

</style>
