<template>
  <div class="post-wrapper">
    <div class="image">
      <img :src="postInfo.image" class="showImage">
    </div>
    <p class="title">{{ postInfo.title }}</p>
    <hr>
    <p class="user-name">{{postInfo.user_name}}</p>
    <div v-if="signedIn" class="btn">
      <button v-if="!currentUser && !followOfState" @click="follow" class="follow">Follow</button>
      <button v-if="!currentUser && followOfState" @click="unfollow" class="follow">UnFollow</button>
      <i v-if="!currentUser && !favoriteOfState" @click="isFavorite" class="far fa-heart unfav"></i>
      <i v-if="!currentUser && favoriteOfState" @click="removeFavorite" class="fas fa-heart fav"></i>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'ShowPost',
    props: ['id'],
    data: function(){
      return {
        postInfo: {},
        allUser: [],
        userInfo: {},
        allRelationships: [],
        allFavorite: [],
        currentUser: false,
        followOfState: false,
        followData: null,
        favoriteOfState: false,
        favoriteData: null,
        signedIn: localStorage.signedIn
      }
    },
    created: function(){
      axios.get(`/api/posts/${this.id}.json`).then(res => {
        this.postInfo = res.data;
        axios.get(`api/users.json`).then(res => {
          this.allUser = res.data.users;
          this.userInfo = this.allUser.find(item => item.email === this.$store.state.user_email) 
          if(this.postInfo.user_id == this.userInfo.id){
            this.currentUser = true
          }
          axios.get(`/relationships.json`).then(res => {
            this.allRelationships = res.data.relationships
            this.followData = this.allRelationships.find(item => item.user_id === this.userInfo.id && item.follow_id === this.postInfo.user_id)
            if( this.followData ){
              this.followOfState = true
            }
          })
          axios.get(`/likes.json`).then(res => {
            this.allFavorite = res.data.likes
            this.favoriteData = this.allFavorite.find(item => item.user_id === this.userInfo.id && item.post_id === this.postInfo.id)
            if( this.favoriteData ){
              this.favoriteOfState = true
            }
          })
        });
      })
    },
    methods: {
      follow(){
        axios.post(`/relationships`, { user_id: this.userInfo.id, follow_id: this.postInfo.user_id}).then((res) => {
          this.followOfState = true
        })
      },
      unfollow(){
        axios.get(`/relationships.json`).then(res => {
          this.allRelationships = res.data.relationships
          this.followData = this.allRelationships.find(item => item.user_id === this.userInfo.id && item.follow_id === this.postInfo.user_id)
        })
        axios.delete(`/relationships/${this.followData.id}`).then((res) => {
          this.followOfState = false
        })
      },
      isFavorite() {
        axios.post(`/likes`, {post_id: this.postInfo.id, user_id: this.userInfo.id}).then((res) => {
          this.favoriteOfState = true
        })
      },
      removeFavorite() {
        axios.get(`/likes.json`).then(res => {
          this.allFavorite = res.data.likes
          this.favoriteData = this.allFavorite.find(item => item.user_id === this.userInfo.id && item.post_id === this.postInfo.is)
        })
        axios.delete(`/likes/${this.favoriteData.id}`).then(res => {
          this.favoriteOfState = false
        })
      },
    }
  }
</script>

<style scoped>
  .post-wrapper{
    padding: 20px;
  }

  .image{
    width: 100%;
    margin: 0 auto;
    text-align: center;
  }

  .showImage{
    width: 70%;
    object-fit: contain;
    margin: 0 auto;
    padding: 5px;
    border: 1px solid #696969;
    display: inline-block;
  }

  .title{
    text-align: center;
    margin-top: 10px;
    margin-bottom: 10px;
  }

  .user-name{
    text-align: center;
    margin-bottom:10px;
  }

  .btn{
    text-align: center;
  }

  .follow{
    width: 100px;
    margin-right: 10px;
  }

  .fav{
    color: rgb(253, 108, 108);
  }
</style>