<template>
  <div class="contents">
    <div>
      <ul class="menu contents-menu">
        <li @click="isSelect('Popular')"
            :class="{'post-active': activeComponent === 'Popular'}"
            class="popular">
            POPULAR<hr></li>
        <li @click="isSelect('Latest')"
            :class="{'post-active': activeComponent === 'Latest'}"
            class="latest">
            LATEST<hr></li>
        <li v-if="signedIn"
            @click="isSelect('Follow')"
            :class="{'post-active': activeComponent === 'Follow'}"
            class="follow">
            FOLLOW<hr></li>
        <li v-if="signedIn"
            @click="isSelect('Favorite')"
            :class="{'post-active': activeComponent === 'Favorite'}"
            class="follow">
            FAVORITE<hr></li>
      </ul>
      <transition name="fade" mode="out-in">
        <component :is="activeComponent"></component>
      </transition>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'

// import Popular from "./PostComponents/Popular.vue"
// import Latest from "./PostComponents/Latest.vue"
// import Follow from "./PostComponents/Follow.vue"
// import Favorite from "./PostComponents/Favorite.vue"

const Popular = () => import("./PostComponents/Popular.vue")
const Latest = () => import("./PostComponents/Latest.vue")
const Follow = () => import("./PostComponents/Follow.vue")
const Favorite = () => import("./PostComponents/Favorite.vue")

export default {
  components: {
    Popular,
    Latest,
    Follow,
    Favorite,
  },
  data: function(){
    return {
      activeComponent: "Popular"
    }
  },
  methods: {
    isSelect: function(component){
      this.activeComponent = component;
    }
  },
  computed: mapState([
    'signedIn'
  ])
}
</script>

<style scoped>
  .contents{
    width: 100%;
  }

  .contents-menu{
    margin: 0 auto;
    padding-top: 50px;
    justify-content: space-around;
    width: 20%;
  }

  .menu{
    display:flex;
    list-style-type: none;
  }

  .menu li{
    margin-left: 20px;
    cursor: pointer;
    color: #DCDCDC;
  }

  .menu .post-active{
    color:#696969;
  }

  .fade-enter, .fade-leave-to{
    opacity: 0;
  }
  .fade-enter-active{
    transition: opacity 1s;
  }
  .fade-leave-active{
    transition: opacity .3s;
  }

</style>