<template>
  <div id="header">
    <header>
      <div class="header-item title">
        <p><a href="/">CONCEPT ME</a></p>
      </div>
      <ul class="header-item menu">
        <li><router-link to="/user">{{ userInfo.name }}</router-link></li>
        <li><span class="signout" @click="signOut">SignOut</span></li>
        <li><i @click="postShow" class="far fa-comment-dots"></i></li>
        <li class="notification-list">
          <i v-click-outside="hide" @click="notificationShow" class="far fa-bell">
            <i v-if="!checkedNotification" class="fa fa-circle"></i>
          </i>
          <div v-if="showNotification" class="notifications-wrapper">
            <div v-for="(notification, index) in notifications" :key='index' class="notification">
              <hr v-if="index > 0">
              <div :class="{notChecked: !notification.checked}">
                {{ insertNotification(notification) }}
                <p class="notificationInfo">{{ insertNotificationInfo(notification) }}</p>
                <p class="text-right">
                  {{ notification.time }}
                </p>
              </div>
            </div>
          </div>
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
  import ClickOutside from 'vue-click-outside'

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
        showNotification: false,
      }
    },
    created: function() {
      axios.get(`api/users.json`).then(res => {
        this.allUser = res.data.users;
        this.userInfo = this.allUser.find(item => item.email === atob(this.$store.state.user_email)) 
        axios.get(`/api/users/${this.userInfo.id}/notification`).then(res => {
          this.notifications = res.data.notifications;
          this.checkedNotification = this.notifications.every(value => value.checked)
        })
      });
    },
    mounted: function() {
      this.$store.dispatch('doFetchSignedIn')
      this.popupItem = this.$el
    },
    methods: {
      signOut() {
        this.$http.secured.delete(`/api/signin`).then(response => {
            delete localStorage.csrf
            delete localStorage.signedIn
            delete localStorage.Vuex
            this.$store.dispatch('doDeleteEmail')
            this.$router.push('/home')
          })
          .catch(error => this.setError(error, 'Cannot sign out'))
      },
      postShow() {
        this.$modal.show("new-post");
      },
      notificationShow(){
        this.showNotification = !this.showNotification
        axios.patch(`/api/users/${this.userInfo.id}/notification`).then(res => {
          this.checkedNotification = true
        })
      },
      hide(){
        this.showNotification = false
        axios.get(`/api/users/${this.userInfo.id}/notification`).then(res => {
          this.notifications = res.data.notifications;
        })
      },
      insertNotification(notification){
        switch(notification.action){
          case 'like':
            return `${notification.visitor.name}さんが${notification.post.title}にいいねしました`;
          case 'comment':
            return `${notification.visitor.name}さんが${notification.post.title}にコメントしました`;
          case 'follow':
            return `${notification.visitor.name}さんからフォローされました`;
        }
      },
      insertNotificationInfo(notification){
        switch(notification.action){
          case 'comment':
            return `${notification.comment.content}`;
        }
      }
    },
    directives: {
      ClickOutside
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

  .title a{
      width: 109px;
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

  .signout{
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

  .notifications-wrapper{
    position: absolute;
    background-color: #fff;
    right: 0;
    border: 1px solid #696969;
    border-radius: 5px;
    line-height: initial;
    box-shadow:1px 0px 10px -3px #878787;
  }

  .notifications-wrapper hr{
    margin: 0;
  }

  .notification div{
    width: 300px;
    padding: 0 10px;
  }

  .notificationInfo{
    color: #afafaf;
  }

  .text-right{
    color: #afafaf;
    text-align: right;
  }

  .notChecked{
    background-color: rgb(247, 247, 247);
    border-radius: 5px;
  }
  
</style>