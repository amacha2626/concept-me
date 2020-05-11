<template>
  <div class="container">
    <form class="col">
      <div class="input-field">
        <label>
          <input type="file" @change="handleFile" required="required" class="image-form" >
          <img :src="uploadedImage" class="uploadedImage">
        </label>
      </div>
      <div class="input-title">
        <input class="title" placeholder="Title" type="text"  v-model="post.title" required="required"><br>
      </div>
      <hr>
      <div class="post-btn" @click="createPost">POST</div>
    </form>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        post: {
          title: '',
          image: null,
          user_id: ''
        },
        uploadedImage: 'assets/photo3.png',
        allUser: [],
        userInfo: {},
      }
    },
    methods: {
      createPost: function () {
        if (!this.post.title) return;
        this.post.user_id = this.userInfo.id
        axios.post('/api/posts', { post: this.post}).then((res) => {
          this.$router.go('/', () => {}, () => {});
        }, (error) => {
          console.log(error);
        });
      },
      handleFile: function(event){
        const file = event.target.files;
        this.createImage(file[0])
      },
      createImage(file){
        const reader = new FileReader();
        reader.onload = e => {
          this.uploadedImage = e.target.result;
          this.post.image = this.uploadedImage
        };
        reader.readAsDataURL(file);
      },
    },
    created: function() {
      axios.get(`/api/users.json`).then(res => {
        this.allUser = res.data.users;
        this.userInfo = this.allUser.find(item => item.email === atob(this.$store.state.user_email)) 
      });
    },
  }
</script>

<style scoped>
  .container{
    padding: 20px;
  }

  .uploadedImage{
    height: 300px;
    width: 300px;
    border:1px dashed #696969;
    object-fit: contain;
  }

  .image-form{
    display: none;
  }

  .title{
    width: 294px;
    margin-top: 10px;
  }

  .post-btn{
    margin: 0 auto;
    margin-top:10px;
    border:1px solid #696969;
    width: 50px;
    font-size:15px;
    text-align: center;
    padding: 5px;
    cursor: pointer;
  }
</style>