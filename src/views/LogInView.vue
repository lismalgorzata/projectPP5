<template>
  <form @submit.prevent="submitForm">
    <div>
      <label for="email">Email</label>
      <input id="email" v-model="form.email" type="email" required />
    </div>
    <div>
      <label for="password">Password</label>
      <input id="password" v-model="form.password" type="password" required />
    </div>
    <button type="submit" :disabled="!isFormValid || loading">Submit</button>
  </form>
</template>

<script>
import { reactive, ref, computed } from 'vue';

export default {
  setup() {
    const form = reactive({
      email: '',
      password: '',
    });

    const errors = ref([]);
    const loading = ref(false);

    const isFormValid = computed(() => {
      return form.email && form.password;
    });

    const validateForm = () => {
      errors.value = [];

      if (!form.email) {
        errors.value.push('Email is required.');
      }

      if (!form.password) {
        errors.value.push('Password is required.');
      }
    };

    const submitForm = async () => {
      validateForm();
      if (isFormValid.value) {
        loading.value = true;

        console.log('Form submitted:', form);

        loading.value = false;
      }
    };

    return { form, errors, loading, isFormValid, submitForm };
  },
};
</script>
