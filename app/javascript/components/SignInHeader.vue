<template>
  <div id="header">
    <header>
      <div class="header-item title">
        <p><a href="#">CONCEPT ME</a></p>
      </div>
      <ul class="header-item menu">
        <li><a href="/" @click="signOut">SignOut</a></li>
        <li>User</li>
        <li><i class="fa fa-bell"></i></li>
      </ul>
    </header>
    <hr class="border">

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
      signUpShow: function(){
        this.$modal.show("signUp");
      },
      signInShow: function(){
        this.$modal.show("signIn");
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
  .border{
    width: 60%;
    margin: 0 auto;
    position: fixed;
    top: 100px;
    margin: 0 20%;
  }

  header{
    width: 100%;
    height: 100px;
    display:flex;
    justify-content: space-between;
    line-height: 100px;
    position: fixed;
    z-index:5;
    background-color: white;
  }

  .title{
    padding-left: 20%;
  }

  .menu{
    display:flex;
    list-style-type: none;
    padding-right: 20%
  }

  .menu li{
    margin-left: 30px;
    cursor: pointer;
  }

  a{
    text-decoration: none;
    color: #696969;
  }
  
</style>