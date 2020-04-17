<template>
  <div class="container">
    <div class="signup-form">
      <h1>Sign UP</h1>
      <hr>
      <form @submit.prevent="signup">
        <div v-if="error">{{ error }}</div>
        <div class="input-form">
          <p>Name</p>
          <input placeholder="Name" type="text" class="validate" v-model="name" required="required"></br>
        </div>
        <div class="input-form">
          <p>Email</p>
          <input placeholder="Email" type="text" class="validate" v-model="email" required="required">
        </div>
        <div class="input-form">
          <p>Password</p>
          <input placeholder="Password" type="password" class="validate" v-model="password" required="required">
        </div>
        <div class="input-form">
          <input placeholder="Password_confirmation" type="password" class="validate" v-model="password_confirmation" required="required">
        </div>
        <button type="submit">Sign Up</button>
      </form>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Signup',
    data() {
      return {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        error: ''
      }
    },
    methods: {
      signup() {
        this.$http.plain.post('/api/signup', { name: this.name, email: this.email, password: this.password, password_confirmation: this.password_confirmation })
          .then(response => this.signupSuccessful(response))
          .catch(error => this.signupFailed(error))
      },
      signupSuccessful(response) {
        if (!response.data.csrf) {
          this.signupFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.$store.state.user_email = btoa(this.email)
        this.$store.dispatch('doFetchSignedIn')
        this.error = ''
        this.$router.replace('/')
      },
      signupFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
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

  .signup-form{
    text-align: center;
  }

  .input-form{
    margin-top:5px;
    margin-bottom: 15px;
  }

  p{
    letter-spacing: .05em;
  }
</style>