<template>
  <div id="header">
    <header>
      <div class="header-item title">
        <p><a href="/">CONCEPT ME</a></p>
      </div>
      <ul class="header-item menu">
        <li><router-link to="/user">{{ userInfo.name }}</router-link></li>
        <li><a href="/" @click="signOut">SignOut</a></li>
        <li @click="postShow"><i class="far fa-comment-dots"></i></li>
        <li><i class="far fa-bell"></i></li>
      </ul>
    </header>
    <hr class="border">
    <modal name="new-post"><NewPost></NewPost></modal>
  </div>
</template>

<script>
  import axios from 'axios'
  import { mapState } from 'vuex'
  import NewPost from "./ModalComponents/NewPost.vue"

  export default {
    components: {
      NewPost,
    },
    computed: mapState([
      'signedIn'
    ]),
    data: function() {
      return {
        allUser: [],
        userInfo: {},
      }
    },
    created: function() {
      axios.get(`api/users.json`).then(res => {
        this.allUser = res.data.users;
        this.userInfo = this.allUser.find(item => item.email === this.$store.state.user_email) 
      });
    },
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
      },
      postShow() {
        this.$modal.show("new-post");
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