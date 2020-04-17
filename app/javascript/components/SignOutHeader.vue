<template>
  <div id="header">
    <header>
      <div class="header-item title">
        <p><a href="/">CONCEPT ME</a></p>
      </div>
      <ul class="header-item menu">
        <li @click="signInShow">Sign in</li>
        <li @click="signUpShow">Sign up</li>
        <li @click="guestSignin">Guest</li>
      </ul>
    </header>
    <modal name="signUp" height="auto" width="300px"><SignUp></SignUp></modal>
    <modal name="signIn" height="auto" width="300px"><SignIn></SignIn></modal>
  </div>
</template>

<script>
  import SignIn from "./ModalComponents/SignIn.vue"
  import SignUp from "./ModalComponents/SignUp.vue"

  export default {
    components: {
      SignIn,
      SignUp,
    },
    methods: {
      signUpShow: function(){
        this.$modal.show("signUp");
      },
      signInShow: function(){
        this.$modal.show("signIn");
      },
      guestSignin() {
        this.$http.plain.post('/api/signin', { email: 'example@example.com', password: 'foobar' })
          .then(response => this.signinSuccessful(response))
          .catch(error => this.signinFailed(error))
      },
      signinSuccessful(response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.$store.state.user_email = btoa('example@example.com')
        this.$store.dispatch('doFetchSignedIn')
        this.error = ''
        this.$router.replace('/')
      },
      signinFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
        delete localStorage.csrf
        delete localStorage.signedIn
      },
    }
  }
</script>


<style scoped>

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
    margin-left: 20px;
    cursor: pointer;
  }

  a{
    text-decoration: none;
    color: #696969;
  }
  
</style>