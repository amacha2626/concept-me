<template>
  <div>
    <SignInHeader></SignInHeader>
    <router-view></router-view>
    <Footer></Footer>
  </div>
</template>

<script>
  import SignInHeader from "../components/SignInHeader.vue"
  import Footer from "../components/Footer.vue"
  import Posts from "../components/Posts.vue"

  import { mapState } from 'vuex'

  export default {
    components: {
      SignInHeader,
      Footer,
      Posts
    },
    computed: mapState([
      'signedIn'
    ]),
    mounted: function() {
      this.$store.dispatch('doFetchSignedIn')
    },
    methods: {
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
  .contents{
    padding-top:100px;
  }
</style>