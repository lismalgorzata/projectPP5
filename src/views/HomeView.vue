<template>
  <div class="home">
    <h2>Listen to this month's album!</h2>

    <iframe
      width="100%"
      height="450"
      scrolling="no"
      frameborder="no"
      allow="autoplay"
      class="soundcloud-player"
      src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/1661520150&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"
    ></iframe>

    <div class="quiz-container">
      <Quiz />
    </div>
  </div>
</template>

<script>
import Quiz from '@/components/Quiz.vue';

export default {
  components: {
    Quiz
  }
}
</script>

<style scoped>
@import "../styles/homeview.scss";
</style>
