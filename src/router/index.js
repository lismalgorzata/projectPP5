import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import LogInView from '@/views/LogInView.vue';
import MusicView from '@/views/MusicView.vue';

const routes = [
  { path: '/', name: 'home', component: HomeView },
  { path: '/login', name: 'login', component: LogInView },
  { path: '/music', name: 'music', component: MusicView },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
