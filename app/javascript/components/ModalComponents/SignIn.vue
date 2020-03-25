<template>
  <div class="container">
    <h1 class="#f3e5f5 purple lighten-5 center">Sign In</h1>
    <form class="col" @submit.prevent="signin">
      <div class="text-red" v-if="error">{{ error }}</div>

      <div class="row">
        <div class="input-field">
          <input placeholder="Email" type="text" class="validate" v-model="email" required="required">
        </div>
      </div>
      <div class="row">
        <div class="input-field">
          <input placeholder="Password" type="password" class="validate" v-model="password" required="required">
        </div>
      </div>

      <button type="submit" class="btn waves-effect waves-light">Sign In</button>
    </form>
  </div>
</template>

<script>
  export default {
    name: 'Signin',
    data() {
      return {
        email: '',
        password: '',
        error: ''
      }
    },
    methods: {
      signin() {
        this.$http.plain.post('/api/signin', { email: this.email, password: this.password })
          .then(response => this.signinSuccessful(response))
          .catch(error => this.signinFailed(error))
      },
      signinSuccessful(response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.$store.state.user_email = this.email
        this.$store.dispatch('doFetchSignedIn')
        this.error = ''
        this.$router.replace('/')
      },
      signinFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
        delete localStorage.csrf
        delete localStorage.signedIn
      },
    }
  }
</script>