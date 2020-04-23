<template>
  <div id="header">
    <header>
      <div class="header-item title">
        <p><a href="/">CONCEPT ME</a></p>
      </div>
      <ul class="header-item menu">
        <li><router-link to="/user">{{ userInfo.name }}</router-link></li>
        <li><a href="/" @click="signOut">SignOut</a></li>
        <li><i @click="postShow" class="far fa-comment-dots"></i></li>
        <li>
          <i @click="showNotification = !showNotification" class="far fa-bell">
            <i v-if="!checkedNotification" class="fa fa-circle"></i>
          </i>
        </li>
      </ul>
    </header>
    <hr class="border">
    <modal name="new-post" height="auto" width="340px"><NewPost></NewPost></modal>
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
        notifications: [],
        checkedNotification: '',
        showNotification: 'false'
      }
    },
    created: function() {
      axios.get(`api/users.json`).then(res => {
        this.allUser = res.data.users;
        this.userInfo = this.allUser.find(item => item.email === atob(this.$store.state.user_email)) 
        axios.get(`/api/users/${this.userInfo.id}/notification`).then(res => {
          this.notifications = res.data.notifications;
          this.checkedNotification = this.notifications.some(value => value.checked)
        })
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
            delete localStorage.Vuex
            this.$store.dispatch('doDeleteEmail')
            this.$router.go('/home')
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
    padding-right: 20%;
  }

  .menu li{
    margin-left: 30px;
  }

  a{
    text-decoration: none;
    color: #696969;
  }

  i{
    padding: 5px;
    cursor: pointer;
  }

  .fa-bell{
    position: relative;
    top: 0;
    right: 0;
  }

  .fa-circle{
    color: red;
    border: 1px solid white;
    border-radius: 50%;
    font-size: 1px;
    padding: 0;
    position: absolute;
    top: 0;
    right: 0;
  }
  
</style>