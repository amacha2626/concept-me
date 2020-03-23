<template>
  <div class="posts">
    <div class="post" v-for="post in reversePosts">
      <img class="img-blur" :src='post.image'>
      <img class="main-img" :src='post.image'>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function() {
    return {
      posts: []
    }
  },
  mounted: function() {
    this.fetchPosts();
  },
  methods: {
    fetchPosts() {
      axios.get('/api/posts').then((res) => {
        for(var i = 0; i < res.data.posts.length; i++) {
          this.posts.push(res.data.posts[i]);
        }
      }, (error) => {
        console.log(error);
      });
    },
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
</style>