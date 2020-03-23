<template>
  <div class="posts">
    <div class="post">
      <img class="img-blur" src="https://images.unsplash.com/photo-1583438799820-74e5f373e175?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
      <img class="main-img" src="https://images.unsplash.com/photo-1583438799820-74e5f373e175?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
    </div>
    <div class="post">
      <img class="img-blur" src="https://images.unsplash.com/photo-1583567268794-067cbeab2394?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
      <img class="main-img" src="https://images.unsplash.com/photo-1583567268794-067cbeab2394?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
    </div>
    <div class="post">
      <img class="img-blur" src="https://images.unsplash.com/photo-1583610995939-95cd478ee11e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
      <img class="main-img" src="https://images.unsplash.com/photo-1583610995939-95cd478ee11e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
    </div>
    <div class="post">
      <img class="img-blur" src="https://images.unsplash.com/photo-1583623733237-4d5764a9dc82?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
      <img class="main-img" src="https://images.unsplash.com/photo-1583623733237-4d5764a9dc82?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80">
    </div>
    <div class="post">
      <img class="img-blur" src="https://images.unsplash.com/photo-1583552188819-4cab7da34a31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80">
      <img class="main-img" src="https://images.unsplash.com/photo-1583552188819-4cab7da34a31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80">
    </div>
    <div class="post">
      <img class="img-blur" src="https://images.unsplash.com/photo-1583550267251-5d138b0275bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80">
      <img class="main-img" src="https://images.unsplash.com/photo-1583550267251-5d138b0275bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80">
    </div>
  </div>
</template>

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