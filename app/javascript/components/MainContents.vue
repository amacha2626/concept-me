<template>
  <div id="main-contents">
    <div>
      <transition 
        enter-active-class="fade animated fadeIn"
        appear>
        <div class="main-wrapper">
          <img src="https://cdn.pixabay.com/photo/2015/05/31/15/18/technology-792180_1280.jpg" class="image">
          <div class="concept-container">
            <p>あなたの日常の全てに、コンセプトを</p>
            <div class="border-white"></div>
          </div>
          <div class="image-white"></div>
        </div>
      </transition>
      <hr class="border">

      <div class="concept">
        <p class="concept-title">About</p>
        <p class="concept-message">
          今日着ていく服、友人と食べたランチ、帰り道の風景<br>
          あなたの日常の1コマに、コンセプトを与えて演出しよう<br>
          共有するのはたった2つ<br>
          その瞬間と、あなたが考えたコンセプトだけ
        </p>
      </div>
    </div>
    <hr class="border">
    <Posts></Posts>
  </div>
</template>

<script>

import Posts from "./Posts.vue"

export default {
  components: {
    Posts,
  }
}
</script>


<style scoped>
  .fade{
    animation-duration: 2s;
  }

  .border{
    width: 60%;
    margin: 0 auto;
    position: sticky;
    top: 100px;
  }

  .concept-container{
    height: calc(100vh - 100px);
    width: 60%;
    margin: 0 auto;
    text-align: center;
    line-height: calc(100vh - 200px);
    padding-top:100px;
  }

  .concept-container p{
    font-size: 30px;
    position:absolute;
    left: 0;
    right: 0;
    margin: auto;
    z-index: 1;
    display: inline;
    letter-spacing: 0.15em;

  }

  .image {
    width: 300px;
    height: 300px;
    border-radius: 50%;
    position: absolute;
    top:0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    z-index: 0;
    border: 3px double #696969;
    filter: opacity(30%);
  }

  .image-white{
    height: 60px;
    position: absolute;
    top:0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    z-index: 0;
    background-color: white;
    filter: blur(7px);
  }

  .concept{
    margin: 50px auto;
  }

  .concept p{
    text-align: center;
  }

  .concept-title{
    font-size: 25px;
    margin-bottom:20px;
  }

  .concept-message{
    letter-spacing: 0.2em;
    line-height: 3em;
  }
</style>