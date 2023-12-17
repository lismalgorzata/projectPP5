<template>
  <div>
    <Header />
    <Container />
  </div>
</template>

<script setup>

import Header from '@/components/Header.vue';
import Container from './components/Container.vue';

</script>

<style>

@import url('https://fonts.googleapis.com/css2?family=Quicksand&display=swap');

body{
  font-family: 'Quicksand', sans-serif;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  background-color: white;
}
</style>
