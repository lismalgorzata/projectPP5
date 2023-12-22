<template>
  <div class="container">

    <!-- Login form using registration data -->
    <form v-if="currentForm === 'login'" @submit.prevent="submitLogin" class="form login-form">
      <h2>Login Form</h2>

      <div class="form-group">
        <label for="loginEmail">Email</label>
        <input id="loginEmail" v-model="loginForm.email" type="email" required />
      </div>

      <div class="form-group">
        <label for="loginPassword">Password</label>
        <input id="loginPassword" v-model="loginForm.password" type="password" required />
      </div>

      <button type="submit">Login</button>

    </form>

    <!-- Registration Form -->
    <form v-if="currentForm === 'registration'" @submit.prevent="submitRegistration" class="form registration-form" >

      <h2>Registration Form</h2>

      <div class="form-group">
        <label for="fullName">Full Name</label>
        <input id="fullName" v-model="registrationForm.fullName" type="text" required />
      </div>

      <div class="form-group">
        <label for="newEmail">Email</label>
        <input id="newEmail" v-model="registrationForm.email" type="email" required />
      </div>

      <div class="form-group">
        <label for="newPassword">Password</label>
        <input id="newPassword" v-model="registrationForm.password" type="password" required />
      </div>

      <div class="form-group">
        <label for="gender">Gender</label>
        <select id="gender" v-model="registrationForm.gender" required>
          <option value="male">Male</option>
          <option value="female">Female</option>
          <option value="other">Other</option>
        </select>
      </div>

      <div class="form-group">

        <label>Who are you?</label>

        <div class="inline-checkbox-group">

          <div class="inline-checkbox">
            <input id="youAreUser" type="checkbox" class="custom-checkbox" v-model="registrationForm.whoareyou.user" />
            <label class="custom-label" for="youAreUser">User</label>
          </div>

          <div class="inline-checkbox">
            <input id="youAreCreator" type="checkbox" class="custom-checkbox" v-model="registrationForm.whoareyou.creator" />
            <label class="custom-label" for="youAreCreator">Creator</label>
          </div>

        </div>
      
      </div>

      <div class="form-group">
        <label for="bio">Bio</label>
        <textarea id="bio" v-model="registrationForm.bio"></textarea>
      </div>

      <button type="submit">Register</button>
      
    </form>

    

  </div>

  <button @click="toggleForm">{{ currentForm === 'login' ? 'Switch to Registration' : 'Switch to Login' }}</button>
</template>

<script>
import { reactive, ref } from 'vue';

export default {
  setup() {
    const registrationForm = reactive({
      fullName: '',
      email: '',
      password: '',
      gender: '',
      whoareyou: {
        user: false,
        creator: false,
      },
      bio: '',
    });

    const loginForm = reactive({
      email: '',
      password: '',
    });

    const registrationComplete = ref(false);
    const currentForm = ref('login'); // 'login' or 'registration'

    const toggleForm = () => {
      currentForm.value = currentForm.value === 'login' ? 'registration' : 'login';
    };

    const submitRegistration = () => {
      // Perform registration logic
      console.log('Registration data:', registrationForm);
    // Use .value to update the ref value
      registrationComplete.value = true;
    };

    const submitLogin = () => {
      // Use registration data for login logic
      if (
        loginForm.email === registrationForm.email &&
        loginForm.password === registrationForm.password
      ) {
        console.log('Login successful!');
      } else {
        console.log('Login failed. Invalid credentials.');
      }
    };

    const resetForm = () => {
      // Reset registration form
      registrationForm.fullName = '';
      registrationForm.email = '';
      registrationForm.password = '';
      registrationForm.gender = '';
      registrationForm.whoareyou.user = false;
      registrationForm.whoareyou.creator = false;
      registrationForm.bio = '';
      registrationComplete.value = false;
    };

    return { registrationForm, loginForm, registrationComplete, currentForm, toggleForm, submitRegistration, submitLogin, resetForm };
  },
};

</script>

<style lang="scss" scoped>
  .container {
    display: flex;
    justify-content: space-between;
    max-width: 1200px;
    margin: 0 auto;
  }
  
  .form {
    flex: 0 0 45%;
    background-color: #f8f9fa;
    border: 1px solid #ced4da;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    
    .form-group {
      margin-bottom: 15px;
      
      label {
        display: block;
        margin-bottom: 5px;
      }
      
      input,
      select,
      textarea {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
      }
      
      .inline-checkbox-group {
        display: flex;
        gap: 10px;
      }

      .inline-checkbox {
        display: flex;
        align-items: center;

        input {
          margin-right: 5px;
          }
      }
    }
  .registration-data {
    flex: 0 0 45%;
    margin-top: 20px;
    padding: 20px;
    border: 1px solid #ced4da;
    background-color: #f8f9fa;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  
  .login-form {
    background-color: #ffffff;
  }
}
</style>
