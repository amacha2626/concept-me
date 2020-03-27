<template>
  <div class="container">
    <h1 class="#f3e5f5 purple lighten-5 center">投稿</h1>
    <form class="col">
      <div class="row">
        <div class="input-field">
          <input placeholder="Title" type="text"  v-model="post.title" required="required"><br>
        </div>
      </div>
      <div class="row">
        <div class="input-field">
          <label>
            <input type="file" @change="handleFile" required="required" class="image-form" >
            <img :src="uploadedImage" class="uploadedImage">
          </label>
        </div>
      </div>
      <div class="btn btn-info waves-effect waves-light" @click="createPost">登録</div>
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
        uploadedImage: '',
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
      axios.get(`api/users.json`).then(res => {
        this.allUser = res.data.users;
        this.userInfo = this.allUser.find(item => item.email === this.$store.state.user_email) 
      });
    },
  }
</script>

<style scoped>
  .uploadedImage{
    height: 100px;
    width: 100px;
  }

  .image-form{
    display: none;
  }
</style>