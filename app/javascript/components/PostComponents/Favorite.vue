<template>
  <div class="posts">
    <div class="post" v-for="(post, key) in reversePosts" :key='key' @click="postShow(post.id)">
      <img class="img-blur" :src='post.image'>
      <img class="main-img" :src='post.image'>
    </div>
    <modal name="show-post" height="auto"><ShowPost :id="post_id"></ShowPost></modal>
  </div>
</template>

<script>
import axios from 'axios'
import ShowPost from '../ModalComponents/ShowPost.vue'


export default {
  components: {
    ShowPost,
  },
  data: function() {
    return {
      posts: [],
      post_id: '',
      allFavorite: [],
      allUsers: [],
      userInfo: {}
    }
  },
  mounted: function() {
    axios.get(`/likes.json`).then(res => {
      this.allFavorite = res.data.likes
      console.log(this.allFavorite)
      axios.get(`api/users.json`).then(res => {
        this.allUsers = res.data.users;
        this.userInfo = this.allUsers.find(item => item.email === atob(this.$store.state.user_email)) 
        for(var i = 0; i < this.allFavorite.length; i++){
          if(this.allFavorite[i].user_id === this.userInfo.id){
            this.posts.push(this.allFavorite[i].post)
          }
        }
      })
    })
  },
  methods: {
    postShow(key){
      this.post_id = key
      this.$modal.show("show-post")
    }
  },
  computed: {
    reversePosts() {
      return this.posts.slice().reverse();
    }
  }
}
</script>

<style scoped>
  .posts{
    width: 100%;
    margin-top: 50px;
    margin-bottom: 50px;
    display:grid;
    grid-auto-rows: 400px;
    grid-template-columns: 1fr 1fr 1fr;
    justify-content: center;
  }

  .post{
    width: 300px;
    height: 300px;
    position:relative;
    margin: 0 auto;
    cursor: pointer;
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
</style>
