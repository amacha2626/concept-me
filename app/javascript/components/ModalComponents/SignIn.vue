<template>
  <div class="container">
    <div class="signin-form">
      <h1>Sign In</h1>
      <hr>
      <form @submit.prevent="signin">
        <div v-if="error">{{ error }}</div>
        <div>
          <p>Email</p>
          <input class="input-form" placeholder="Email" type="text" v-model="email" required="required">
        </div>
        <div>
          <p>Password</p>
          <input class="input-form" placeholder="Password" type="password" v-model="password" required="required">
        </div>
        <button type="submit">Sign In</button>
      </form>
    </div>
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
        this.$store.state.user_email = btoa(this.email)
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

<style scoped>
  .container{
    width: 260px;
    padding: 20px;
  }

  .signin-form{
    text-align: center;
  }

  .input-form{
    margin-top: 5px;
    margin-bottom: 15px;
  }

  p{
    letter-spacing: .05em;
  }
</style>