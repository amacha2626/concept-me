<template>
  <div>
    <SignOutHeader></SignOutHeader>
    <MainContents></MainContents>
    <Footer></Footer>
  </div>
</template>

<script>
  import SignOutHeader from "../components/SignOutHeader.vue"
  import Footer from "../components/Footer.vue"
  import MainContents from "../components/MainContents.vue"

  export default {
    components: {
      SignOutHeader,
      Footer,
      MainContents
    }
  }
</script>