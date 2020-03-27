<template>
  <div>
    <p>{{ postInfo.title }}</p>
    <img :src="postInfo.image" class="showImage">
    <p>{{postInfo.user_name}}</p>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'ShowPost',
    props: ['id'],
    data: function(){
      return {
        postInfo: {}
      }
    },
    created: function(){
      axios.get(`/api/posts/${this.id}.json`).then(res => {
        this.postInfo = res.data;
      })
    }
  }
</script>

<style scoped>
  .showImage{
    width: 300px;
    height: 300px;
    object-fit: contain;
  }
</style>