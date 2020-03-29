<template>
  <div>
    <p>{{ postInfo.title }}</p>
    <img :src="postInfo.image" class="showImage">
    <p>{{postInfo.user_name}}</p>
    <button v-if="!currentUser && !followOfState" @click="follow">Follow</button>
    <button v-if="!currentUser && followOfState" @click="unfollow">UnFollow</button>
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
        currentUser: false,
        followOfState: false,
        followData: null
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
      }
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