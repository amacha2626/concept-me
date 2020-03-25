<template>
  <div id="header">
    <header>
      <div class="header-item title">
        <p><a href="/">CONCEPT ME</a></p>
      </div>
      <ul class="header-item menu">
        <li @click="signInShow">Sign in</li>
        <li @click="signUpShow">Sign up</li>
        <li>Guest</li>
      </ul>
    </header>
    <modal name="signUp" height="70%" width="30%"><SignUp></SignUp></modal>
    <modal name="signIn" height="60%" width="30%"><SignIn></SignIn></modal>
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