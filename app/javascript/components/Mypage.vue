<template>
  <div class="main-wrapper">
    <div class="profile">
      <div class="username">
        <span @click="isSelect('posts')">{{ userInfo.name }}</span>
      </div>
      <div class="follow-wrapper">
        <div @click="isSelect('follow')"><span>{{followCount}}</span>follow</div>
        <div @click="isSelect('follower')"><span>{{followerCount}}</span>follower</div>
      </div>
      <hr>
    </div>
    <div class="posts" v-if="activeView === 'posts'">
      <div class="post" v-for="(post, key) in posts" :key='key' @click="postShow(post.id)">
        <img class="img-blur" :src='post.image'>
        <img class="main-img" :src='post.image'>
      </div>
      <modal name="show-post" height="auto"><ShowPost :id="post_id"></ShowPost></modal>
    </div>
    <div class="follow-lists follow" v-if="activeView === 'follow'">
      <p>Follow</p>
      <div class="lists" v-for="(follow, key) in userInfo.followings" :key='key'>
        <div class=list>
          <router-link :to="`/user/${follow.id}`">{{ follow.name }}</router-link>
        </div>
      </div>
    </div>
    <div class="follow-lists follower" v-if="activeView === 'follower'">
      <p>Follower</p>
      <div class="lists" v-for="(follower, key) in userInfo.followers" :key='key'>
        <div class="list">
          <router-link :to="`/user/${follower.id}`">{{ follower.name }}</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import ShowPost from './ModalComponents/ShowPost.vue'

  export default {
    components: {
      ShowPost,
    },
    data: function() {
      return {
        allUser: [],
        userInfo: {},
        selectUserInfo: {},
        posts: [],
        post_id: '',
        followCount: '',
        followerCount: ',',
        activeView: 'posts'
      }
    },
    created: function() {
      axios.get(`/api/users.json`).then(res => {
        this.allUser = res.data.users;
        this.userInfo = this.allUser.find(item => item.email === atob(this.$store.state.user_email)) 
        this.followCount = this.userInfo.followings.length
        this.followerCount = this.userInfo.followers.length
        this.fetchPosts();
      });
    },
    methods: {
      fetchPosts() {
        axios.get('/api/posts').then(res => {
          for(var i = 0; i < res.data.posts.length; i++) {
            if(res.data.posts[i].user_id === this.userInfo.id) {
              this.posts.push(res.data.posts[i]);
            }
          }
        }, (error) => {
          console.log(error);
        });
      },
      postShow(key){
        this.post_id = key
        this.$modal.show("show-post")
      },
      isSelect(view){
        this.activeView = view;
      },
    }
  }
</script>

<style scoped>
  .main-wrapper{
    padding-top: 100px;
  }

  .profile{
    padding-top:20px;
    text-align: center;
    width: 60%;
    margin: 0 auto;
  }

  hr{
    margin: 20px 0;
  }

  .posts{
    width: 100%;
    margin-top: 50px;
    margin-bottom: 50px;
    display:grid;
    grid-template-rows: 400px;
    grid-template-columns: 1fr 1fr 1fr;
    justify-content: center;
  }

  .post{
    width: 300px;
    height: 300px;
    position:relative;
    margin: 0 auto;
  }

  .img-blur{
    width: 300px;
    height: 300px;
    object-fit: cover;
    border:1px solid #696969;
    filter: opacity(10%);
  }

  .main-img{
    width: 100%;
    height: 100%;
    object-fit: contain;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    margin: auto;
  }

  .post::before, .post::after {
    content: '';
    position: absolute;
    transition: all 0.3s;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
}

  .post::before {
    left: 4px;
    z-index: 1;
    opacity: 0;
    background: rgba(255, 255, 255, 0.3);
    transform: scale(1, 0.1);
  }

  .post:hover::before {
    opacity: 1;
    transform: scale(1, 1);
  }

  .post::after {
    transition: all 0.3s;
  }

  .post:hover::after {
    transform: scale(.1, 1);
    opacity: 0;
  }

  .username{
    cursor: pointer;
  }

  .username :hover{
    border-bottom: 0.5px solid #696969;
  }

  .follow-wrapper{
    margin-top: 10px;
    font-size: 11px;
  }

  .follow-wrapper div{
    margin: 0 5px;
    display: inline;
    cursor: pointer;
  }

  .follow-wrapper :hover{
    border-bottom: 0.5px solid #696969;
  }

  .follow-wrapper span{
    font-size: 15px;
    margin-right: 3px;
  }

  .follow-lists{
    text-align: center;
    margin-bottom: 20px;
  }

  .list{
    margin-top: 15px;
  }
</style>