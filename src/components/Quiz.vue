<template>
    <div>
      <h1>{{ quizTitle }}</h1>
      <div v-if="!quizCompleted">
        <div v-if="currentQuestion">
          <h2>{{ currentQuestion.question }}</h2>
  
          <template v-if="currentQuestion.type === 'text'">
            <input type="text" v-model="textInput" />
          </template>
          <template v-else-if="currentQuestion.type === 'checkbox'">
            <div v-for="(option, index) in currentQuestion.options" :key="index" class="inline-checkbox">
              <input type="checkbox" :value="index" v-model="checkboxOptions" />
              {{ option }}
            </div>
          </template>          
          <template v-else-if="currentQuestion.type === 'select'">
            <select v-model="selectedOption">
              <option v-for="(option, index) in currentQuestion.options" :key="index" :value="index">
                {{ option }}
              </option>
            </select>
          </template>
          <template v-else-if="currentQuestion.type === 'number'">
            <input type="number" v-model="numberInput" min="0" max="100"/>
          </template>
          <template v-else-if="currentQuestion.type === 'textarea'">
            <textarea v-model="textAreaInput"></textarea>
          </template>
          <template v-else-if="currentQuestion.type === 'radio'">
            <div v-for="(option, index) in currentQuestion.options" :key="index" class="inline-radio">
              <input type="radio" :value="index" v-model="radioOption" />
              {{ option }}
            </div>
          </template>          
          <br>
          <button @click="checkAnswer">Check Answer</button>
      </div>
    </div>
    <div v-else>
      <h2 v-if="score === questions.length">Congratulations! You completed the quiz.</h2>
      <h2 v-else>Sorry! You didn't complete the quiz. Better luck next time!</h2>
      <p>Your score: {{ score }}/{{ questions.length }}</p>
      <button class="restart-button" v-if="score < questions.length" @click="restartQuiz">Restart Quiz</button>
    </div>
  </div>
</template>
  
  <script>
  export default {
    data() {
      return {
        quizTitle: "Music Quiz",
        questions: [
          { question: "Who is known as the \"Queen of Pop\"?", type: "text", correctAnswer: "Madonna" },
          { question: "In which music genre did Ella Fitzgerald primarily make her mark as a legendary vocalist?", type: "checkbox", options: ["Pop", "Blues", "Rock and roll", "Jazz"], correctAnswer: [3]},
          { question: "Choose the most popular music streaming platform:", type: "select", options: ["Apple Music", "Spotify", "Amazon Music", "Other"], correctAnswer: 1 },
          { question: "How many Grammy Awards did Adele win in a single night for her record-breaking album \"21\" at the 54th Annual Grammy Awards in 2012?", type: "number", correctAnswer: 6 },
          { question: "What was the title of the song with which ABBA won Eurovision in 1974?", type: "textarea", correctAnswer: "Waterloo" },
          { question: "Whose song is \"Billie Jean\"?", type: "radio", options: ["Michael Jackson", "The Beatles", "Queen", "Elvis Presley"], correctAnswer: 0 },
        ],
        currentQuestionIndex: 0,
        textInput: "",
        checkboxOptions: [],
        selectedOption: null,
        numberInput: null,
        textAreaInput: "",
        radioOption: null,
        score: 0,
        quizCompleted: false,
        initialQuizState: null,
      };
    },
    computed: {
        currentQuestion() {
        return this.questions[this.currentQuestionIndex];
        },
    },
    methods: {
        checkAnswer() {
            switch (this.currentQuestion.type) {
                case "text":
                    if (this.textInput.trim().toLowerCase() === this.currentQuestion.correctAnswer.toLowerCase()) {
                        this.score++;
                    }
                    break;
                case "textarea":
                    if (this.textAreaInput.trim().toLowerCase() === this.currentQuestion.correctAnswer.toLowerCase()) {
                        this.score++;
                    }
                    break;
                case "checkbox":
                    const correctOptions = this.currentQuestion.correctAnswer;
                    const selectedIndices = this.checkboxOptions.map(Number);
                    if (
                        selectedIndices.length === correctOptions.length &&
                        selectedIndices.every((index) => correctOptions.includes(index))
                    ) {
                        this.score++;
                    }
                    break;
                case "select":
                    if (this.selectedOption === this.currentQuestion.correctAnswer) {
                        this.score++;
                    }
                    break;
                case "radio":
                    if (this.radioOption === this.currentQuestion.correctAnswer) {
                        this.score++;
                    }
                    break;
                case "number":
                    if (Number(this.numberInput) === this.currentQuestion.correctAnswer) {
                        this.score++;
                    }
                    break;
            }

                // Move to the next question or complete the quiz
                this.currentQuestionIndex++;
                if (this.currentQuestionIndex === this.questions.length) {
                this.quizCompleted = true;
                }
        },
        restartQuiz() {
        // Reset quiz state
            this.quizCompleted = false;
            this.currentQuestionIndex = 0;
            this.score = 0;
            this.textInput = "";
            this.checkboxOptions = [];
            this.selectedOption = null;
            this.numberInput = null;
            this.textAreaInput = "";
            this.radioOption = null;

            // Save the initial state for resetting later
            if (!this.initialQuizState) {
                this.initialQuizState = JSON.parse(JSON.stringify(this.$data));
            } else {
                // Restore initial state
                Object.assign(this.$data, JSON.parse(JSON.stringify(this.initialQuizState)));
            }
        },
    },
};

</script>
  
<style scoped lang="scss">
@import "../styles/quiz.scss";
</style>
  