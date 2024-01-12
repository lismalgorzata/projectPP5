<template>
  <div>
    <Header :user-logged-in="handleUserLoggedIn"/>
    <Container />
  </div>
</template>
<App @userLoggedIn="handleUserLoggedIn" />

<script setup>

import Header from '@/components/Header.vue';
import Container from './components/Container.vue';

const handleUserLoggedIn = () => {
  // Przekaż informację o zalogowanym użytkowniku do Header.vue
  // W tym przypadku można zaktualizować stan komponentu Header.vue
  // lub ponownie załadować całą aplikację.
};

</script>

<style lang="scss">
@import "styles/main.scss";
</style>
