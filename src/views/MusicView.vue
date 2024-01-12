<template>
  <div>
    <h1>Music Library</h1>

    <button @click="togglePage">
      {{ currentPage === 'library' ? 'Add new audio' : 'See the library' }}
    </button>

    <div class="library-page">
      <div class="musicLibrary" v-if="currentPage === 'library'">
        <div v-for="file in audio_files" :key="file.id">
          <h2>{{ file.name + ' ' + file.author }}</h2>
        </div>
      </div>

      <div class="addToLibrary" v-if="currentPage === 'add'">

        <h2>Add Song</h2>

        <form @submit.prevent="submitAudioForm">
          <label for="name">Name: </label>
          <input type="text" v-model="formData.name" required>

          <label for="author">Author:</label>
          <input type="text" v-model="formData.author" required>

          <label for="date">Date:</label>
          <input type="date" v-model="formData.date" required>

          <label for="genre">Genre:</label>
          <input type="text" v-model="formData.genre" required>

          <label for="stars">Stars:</label>
          <input type="number" v-model="formData.stars" min="0" max="10" required>

          <div class="inline-checkbox">
            <input type="checkbox" v-model="formData.favourite">
            <label for="favourite">Favourite</label>
          </div>

          <label for="url">URL:</label>
          <input type="url" v-model="formData.url" required>

          <label for="color">Color:</label>
          <input type="color" v-model="formData.color" required>

          <button type="submit">Submit</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      audio_files: [],
      formData: {
        name: '',
        author: '',
        date: '',
        genre: '',
        stars: 0,
        favourite: false,
        url: '',
        color: '#000000'
      },
      currentPage: 'library'
    };
  },
  mounted() {
    this.fetchAudioFiles();
  },
  methods: {
    fetchAudioFiles() {
      axios.get('http://localhost:3000/audio_files')
        .then(res => {
          this.audio_files = res.data;
        })
        .catch(err => console.log(err.message));
    },
    submitAudioForm() {
      axios.post('http://localhost:3000/audio_files', this.formData)
        .then(res => {
          this.audio_files.push(res.data);
        })
        .catch(err => console.log(err));

      this.formData = {
        name: '',
        author: '',
        date: '',
        genre: '',
        stars: 0,
        favourite: false,
        url: '',
        color: '#000000'
      };

      this.togglePage(); // Fixed: Call togglePage method
      this.fetchAudioFiles();
    },
    togglePage() {
      this.currentPage = this.currentPage === 'library' ? 'add' : 'library';
    }
  }
};
</script>

<style scoped lang="scss">
@import "../styles/musicview.scss";
</style>