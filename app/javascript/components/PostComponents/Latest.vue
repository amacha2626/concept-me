<template>
  <div class="posts">
    <div class="post" v-for="(post, key) in posts" :key='key' @click="postShow(post.id)">
      <img class="img-blur" :src='post.image'>
      <img class="main-img" :src='post.image'>
    </div>
    <modal name="show-post" height="70%" width="30%"><ShowPost :id="post_id"></ShowPost></modal>
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
      post_id: ''
    }
  },
  mounted: function() {
    this.fetchPosts();
  },
  methods: {
    fetchPosts() {
      axios.get('/api/posts').then(res => {
        for(var i = 0; i < res.data.posts.length; i++) {
          this.posts.push(res.data.posts[i]);
        }
      }, (error) => {
        console.log(error);
      });
    },
    postShow(key){
      this.post_id = key
      this.$modal.show("show-post")
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
</style>