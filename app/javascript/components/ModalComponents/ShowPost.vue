<template>
  <div>
    <p>{{ postInfo.title }}</p>
    <img :src="postInfo.image" class="showImage">
    <p>{{postInfo.user_name}}</p>
    <button v-if="!currentUser && !followOfState" @click="follow">Follow</button>
    <button v-if="!currentUser && followOfState" @click="unfollow">UnFollow</button>
    <i v-if="!currentUser && !favoriteOfState" @click="isFavorite" class="far fa-heart"></i>
    <i v-if="!currentUser && favoriteOfState" @click="removeFavorite" class="fas fa-heart"></i>
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
  .showImage{
    width: 300px;
    height: 300px;
    object-fit: contain;
  }
</style>