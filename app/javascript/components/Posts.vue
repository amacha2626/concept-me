<template>
  <div class="contents">
    <div>
      <ul class="menu contents-menu">
        <li @click="isSelect('1')"
            v-bind:class="{'post-active': isActive === '1'}"
            class="popular">
            POPULAR<hr></li>
        <li @click="isSelect('2')"
            v-bind:class="{'post-active': isActive === '2'}"
            class="latest">
            LATEST<hr></li>
        <li
          v-if="signedIn"
        >FOLLOW<hr></li>
        <li
          v-if="signedIn"
        >FAVORITE<hr></li>
      </ul>
      <div v-if="isActive==='1'" class="posts popular">
        <Popular></Popular>
      </div>
      <div v-else-if="isActive==='2'" class="posts latest">
        <Latest></Latest>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import Popular from "./PostComponents/Popular.vue"
import Latest from "./PostComponents/Latest.vue"

export default {
  components: {
    Popular,
    Latest,
  },
  data: function(){
    return {
      isActive: "1"
    }
  },
  methods: {
    isSelect: function(num){
      this.isActive = num;
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

</style>