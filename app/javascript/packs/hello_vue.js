import Vue from 'vue/dist/vue.esm'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    data: {
      answer: "",
      note: ""
    },
    methods: {
      addAnswerToNote: function (){
        this.note += this.answer
        this.note += "\n"
        this.answer = ""
      }
    }
  })
})
