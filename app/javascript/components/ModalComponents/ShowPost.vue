<template>
  <div>
    <div class="post-wrapper">
      <div class="image">
        <img :src="postInfo.image" class="showImage">
      </div>
      <p class="title">{{ postInfo.title }}</p>
      <hr>
      <p class="user-name"><router-link :to="`/user/${postInfo.user_id}`">{{postInfo.user_name}}</router-link></p>
      <div v-if="signedIn" class="btn">
        <button v-if="!currentUser && !followOfState" @click="follow" class="follow">Follow</button>
        <button v-if="!currentUser && followOfState" @click="unfollow" class="follow">UnFollow</button>
        <i v-if="!currentUser && !favoriteOfState" @click="isFavorite" class="far fa-heart unfav"></i>
        <i v-if="!currentUser && favoriteOfState" @click="removeFavorite" class="fas fa-heart fav"></i>
      </div>
      <div class="comments">
        <hr>
        <div class="comment" v-for="(comment, key) in comments" :key='key'>
          <router-link :to="`/user/${comment.comment_user.id}`">{{ comment.comment_user.name }}</router-link>
          -
          {{ comment.comment_content }}
          <span class="delete" @click="deleteComment(comment.comment_id)" v-if="userInfo.id === comment.comment_user.id">×</span>
          <hr>
        </div>
        <form @submit.prevent v-if="signedIn">
          <div class="comment-form">
            <input v-model="comment" type="text" placeholder="comment..." class="comment-input">
            <input @click="postComment" type="submit" value="Post" class="comment-submit">
          </div>
        </form>
      </div>
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
        signedIn: localStorage.signedIn,
        comments: [],
        comment: '',
      }
    },
    created: function(){
      axios.get(`/api/posts/${this.id}.json`).then(res => {
        this.postInfo = res.data;
        this.comments = this.postInfo.comments
        if(localStorage.signedIn){
          axios.get(`/api/users.json`).then(res => {
            this.allUser = res.data.users;
            this.userInfo = this.allUser.find(item => item.email === atob(this.$store.state.user_email)) 
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
        }
      })
    },
    methods: {
      follow(){
        this.followOfState = true
        axios.post(`/relationships`, {user_id: this.userInfo.id, follow_id: this.postInfo.user_id})
      },
      unfollow(){
        this.followOfState = false
        axios.get(`/relationships.json`).then(res => {
          this.allRelationships = res.data.relationships
          this.followData = this.allRelationships.find(item => item.user_id === this.userInfo.id && item.follow_id === this.postInfo.user_id)
        })
        axios.delete(`/relationships/${this.followData.id}`)
      },
      isFavorite() {
        this.favoriteOfState = true
        axios.post(`/likes`, {
                    post_id: this.postInfo.id, user_id: this.userInfo.id,
                    visited_id: this.postInfo.user_id,}).then((res) => {
        })
      },
      removeFavorite() {
        this.favoriteOfState = false
        axios.get(`/likes.json`).then(res => {
          this.allFavorite = res.data.likes
          this.favoriteData = this.allFavorite.find(item => item.user_id === this.userInfo.id && item.post_id === this.postInfo.is)
        })
        axios.delete(`/likes/${this.favoriteData.id}`)
      },
      postComment(){
        axios.post(`/api/comments`,{
                    comment: { content: this.comment, user_id: this.userInfo.id, post_id: this.id },
                    visitor_id: this.userInfo.id, visited_id: this.postInfo.user_id, post_id: this.postInfo.id}).then(res => {
          axios.get(`/api/posts/${this.id}.json`).then(res => {
            this.postInfo = res.data;
            this.comments = this.postInfo.comments
            this.comment = ''
          })
        })
      },
      deleteComment(comment_id){
        axios.delete(`/api/comments/${comment_id}`).then(res => {
          var comments = this.comments
          comments.some(function(value,index){
            if (value.comment_id === comment_id){
              comments.splice(index, 1)
            }
          })
          this.comments = comments
        })
      },
    }
  }
</script>

<style scoped>
  .post-wrapper{
    padding: 20px;
    max-height: 80vh;
    scroll-behavior: auto;
    overflow: scroll;
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
    cursor: pointer;
  }

  .fav{
    color: rgb(253, 108, 108);
  }

  .fa-heart{
    cursor: pointer;
  }

  .comments{
    width: 80%;
    margin: 0 auto;
    font-size: 15px;
  }

  .delete{
    float: right;
  }

  .comment-form{
    position: relative;
    padding-bottom:20px;
  }

  .comment-input{
    width: calc(100% - 6px);
    float:left;
    height: 20px;
    margin-bottom: 20px;
  }

  .comment-submit{
    position: absolute;
    float: right;
    right:5px;
    top:3px;
    border: none;
  }
  .comment-submit:focus{
    outline: 0;
  }
</style>