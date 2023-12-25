<template>
  <div class="library-page">
    <div class="musicLibrary">
      <h2>Music View Library Page</h2>
      <div v-for="file in audio_files" :key="file.id">
        <h2>{{ file.name +" "+ file.author }}</h2>
      </div>
    </div>

    <div class="add-page">
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
        <input type="number" v-model="formData.stars" required>

        <label for="favourite">Favourite:</label>
        <input type="checkbox" v-model="formData.favourite">

        <label for="url">URL:</label>
        <input type="url" v-model="formData.url" required>

        <label for="color">Color:</label>
        <input type="color" v-model="formData.color" required>

        <button type="submit">Submit</button>
      </form>
    </div>
  </div>
</template>

<script>
// Import Axios at the top
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
      }
    };
  },
  mounted() {
    this.fetchAudioFiles();
  },
  methods: {
    fetchAudioFiles() {
      fetch('http://localhost:3000/audio_files')
        .then(res => res.json())
        .then(data => (this.audio_files = data))
        .catch(err => console.log(err.message));
    },
    submitAudioForm() {
      // Handle form submission logic here
      console.log('Form submitted:', this.formData);

      // Assuming you want to add the new audio file to the list
      // You can adjust this part based on your server/API logic
      axios.post('http://localhost:3000/audio_files', this.formData)
        .then(res => {
          console.log(res);
          // Use the data returned by the server to update UI or perform actions
          this.audio_files.push(res.data);
        })
        .catch(err => console.log(err));

      // Reset the form data for the next entry
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

      // Fetch audio files after successful submission
      this.fetchAudioFiles();
    }
  }
};
</script>
