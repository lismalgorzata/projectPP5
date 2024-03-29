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

  <button class="toggleBtn" @click="toggleForm">{{ currentForm === 'login' ? 'Switch to Registration' : 'Switch to Login' }}</button>
</template>

<script>
import { reactive, ref , onMounted } from 'vue';
import axios from 'axios';
import { useStore } from 'vuex';

export default {
  setup() {
    const store = useStore();

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

    const registeredUsers = ref([]);

    const toggleForm = () => {
      currentForm.value = currentForm.value === 'login' ? 'registration' : 'login';
    };

    const submitRegistration = async () => {
      try {
        // Perform registration logic
        console.log('Registration data:', registrationForm);

        // Use Axios to post registration data to the server
        await axios.post('http://localhost:3000/users', {
          fullName: registrationForm.fullName,
          email: registrationForm.email,
          password: registrationForm.password,
          gender: registrationForm.gender,
          whoareyou: { ...registrationForm.whoareyou },
          bio: registrationForm.bio,
        });

        // Use .value to update the ref value
        registrationComplete.value = true;
      } catch (error) {
        console.error('Error during registration:', error);
      }
    };

    const isLoggedIn = ref(false); 

    const submitLogin = () => {
      // Use Axios to fetch users from the server
      axios.get('http://localhost:3000/users').then((response) => {
        const users = response.data;
        const user = users.find(
          (u) => u.email === loginForm.email && u.password === loginForm.password
        );

        if (user) {
          console.log('Login successful!', user);
          store.commit('setCurrentUser', user)
          store.dispatch('login', user);
          isLoggedIn.value = true;
          emit('userLoggedIn');
        } else {
          console.log('Login failed. Invalid credentials.');
        }
      }).catch((error) => {
        console.error('Error during login:', error);
      });
    };

    onMounted(() => {
    if (isLoggedIn.value) {
      // Wyslij zdarzenie, gdy użytkownik jest zalogowany
      emit('userLoggedIn');
    }
  });

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

    return {
      registrationForm,
      loginForm,
      registrationComplete,
      currentForm,
      isLoggedIn,
      toggleForm,
      submitRegistration,
      submitLogin,
      resetForm,
      registeredUsers,
    };
  },
};

</script>

<style scoped lang="scss">
@import "../styles/loginview.scss";
</style>