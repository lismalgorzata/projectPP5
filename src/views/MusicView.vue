<template>
  <div class="musicLibrary">
    <h2>Music View Library Page</h2>
  </div>

  <div v-for="file in audio_files" :key="file.id">
      <h2>{{ file.name +" "+ file.author }}</h2>
  </div>
</template>

<script>
  export default{
    data() {
      return{
        audio_files: []
      }
    },
    mounted() {
      fetch('http://localhost:3000/audio_files')
        .then(res => res.json())
        .then(data => this.audio_files = data)
        .catch(err => console.log(err.message))
    }
  }
  
</script>
