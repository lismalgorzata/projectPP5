<template>
    <div class="appHeader">
      <div class="left">
        <img src="@/assets/logo.png" alt="Logo" class="logo" />
      </div>
      <div class="right">
        <div @click="goToMusicPage" class="musicIcon">
          <svg xmlns="http://www.w3.org/2000/svg" 
              width="28" 
              height="28" 
              viewBox="0 0 24 24" 
              fill="none" 
              stroke="currentColor" 
              stroke-width="2" 
              stroke-linecap="round" 
              stroke-linejoin="round" 
              class="feather feather-music">
              
              <path d="M9 18V5l12-2v13"/>
              <circle cx="6" cy="18" r="3"/>
              <circle cx="18" cy="16" r="3"/>
          </svg>
        </div>
        <div @click="goToMainPage" class="homeIcon">
          <svg xmlns="http://www.w3.org/2000/svg" 
              width="28" 
              height="28" 
              viewBox="0 0 24 24" 
              fill="none" 
              stroke="currentColor" 
              stroke-width="2" 
              stroke-linecap="round" 
              stroke-linejoin="round" 
              class="feather feather-home">
              
              <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
              <polyline points="9 22 9 12 15 12 15 22"/>
          </svg>
        </div>
        <div @click="goToLoginPage" class="loginIcon">
          <svg xmlns="http://www.w3.org/2000/svg" 
              width="28" 
              height="28" 
              viewBox="0 0 24 24" 
              fill="none" 
              stroke="currentColor" 
              stroke-width="2" 
              stroke-linecap="round" 
              stroke-linejoin="round" 
              class="feather feather-user">
              
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
              <circle cx="12" cy="7" r="4"/>
          </svg>
        </div>
      </div>
    </div>
</template>
  
<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const goToMainPage = () => {
  router.push({ name: 'home' });
};

const goToMusicPage = () => {
  router.push({ name: 'music' });
};

const goToLoginPage = () => {
  router.push({ name: 'login' });
};

</script>
  
<style scoped>
  .appHeader {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 48px;
    border-bottom: 1px solid rgb(180, 180, 180);
    background-color: rgb(206, 208, 211);
  }
  
  .logo {
    cursor: pointer;
    width: 80px;
    height: 60px;
  }
  
  .left {
    display: flex;
    align-items: center;
  }
  
  .right {
    display: flex;
    gap: 50px; 
  }

  .musicIcon{
    cursor: pointer;
  }
  .musicIcon:hover{
    color: blue;
  }
  .homeIcon{
    cursor: pointer;
  }
  .homeIcon:hover{
    color: blue;
  }
  .loginIcon{
    cursor: pointer;
  }
  .loginIcon:hover{
    color: blue;
  }

</style>
  