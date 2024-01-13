<template>
  <div>
    <h1>Music Library</h1>

    <button @click="togglePage">{{ currentPage === 'library' ? 'Add Song' : 'Back to Library' }}</button>

    <div class="library-page">
      <div class="musicLibrary" v-if="currentPage === 'library'">
        <div v-for="file in audio_files" :key="file.id" @click="displaySongDetails(file)">
          <h2>{{ file.name }}</h2>
        </div>
      </div>

      <div class="addToLibrary" v-if="currentPage === 'add'">
        <h2>{{ selectedSong ? 'Edit Song' : 'Add Song' }}</h2>

        <form @submit.prevent="selectedSong ? updateAudioForm() : submitAudioForm()">
          <label for="name">Name: </label>
          <input type="text" v-bind:readonly="selectedSong" v-model="formData.name" required>

          <label for="author">Author:</label>
          <input type="text" v-bind:readonly="selectedSong" v-model="formData.author" required>

          <label for="date">Date:</label>
          <input type="date" v-bind:readonly="selectedSong" v-model="formData.date" required>

          <label for="genre">Genre:</label>
          <input type="text" v-bind:readonly="selectedSong" v-model="formData.genre" required>

          <label for="stars">Stars:</label>
          <input type="number"  v-model="formData.stars" min="0" max="10" required>

          <div class="inline-checkbox">
            <input type="checkbox" v-model="formData.favourite">
            <label for="favourite">Favourite</label>
          </div>

          <label for="url">URL:</label>
          <input type="url" v-bind:readonly="selectedSong" v-model="formData.url" required>

          <label for="color">Color:</label>
          <input type="color" v-model="formData.color" required>

          <button type="submit">{{ selectedSong ? 'Update' : 'Submit' }}</button>
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
      currentPage: 'library',
      selectedSong: null
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

      this.resetFormData();
      this.togglePage();
      this.fetchAudioFiles();
    },
    updateAudioForm() {
      axios.put(`http://localhost:3000/audio_files/${this.selectedSong.id}`, this.formData)
        .then(() => {
          this.fetchAudioFiles();
        })
        .catch(err => console.log(err));

      this.selectedSong = null;
      this.resetFormData();
    },
    resetFormData() {
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
    },
    displaySongDetails(song) {
      this.selectedSong = song;
      this.currentPage = 'add';

      this.formData.name = song.name;
      this.formData.author = song.author;
      this.formData.date = song.date;
      this.formData.genre = song.genre;
      this.formData.stars = song.stars;
      this.formData.favourite = song.favourite;
      this.formData.url = song.url;
      this.formData.color = song.color;
    },
    togglePage() {
    if (this.currentPage === 'library') {
      // Przenosimy się do strony 'add', zresetuj selectedSong i dane formularza
      this.currentPage = 'add';
      this.selectedSong = null;
      this.resetFormData();
    } else {
      // Przenosimy się z powrotem do strony 'library'
      this.currentPage = 'library';
    }
  }
  }
};
</script>

<style scoped lang="scss">
@import "../styles/musicview.scss";
</style>
