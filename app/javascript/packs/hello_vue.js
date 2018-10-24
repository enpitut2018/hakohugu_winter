import Vue from 'vue/dist/vue.esm'
import axios from 'axios';

document.addEventListener('DOMContentLoaded', () => {

  const app = new Vue({
    el: '#app',
    data: {
      answer: "",
      note: "",
      question: []
    },
    methods: {

      addAnswerToNote: function (){
        this.note += this.question[0]
        this.note += "\n"
        this.note += this.answer
        this.note += "\n"
        this.answer = ""
      },
      hoge: function(id){
        axios.get(`api/questions/${id}`)
             .then(res => {
               this.question.push(res.data.title);
               this.addAnswerToNote();
             });

      }
    }
  })
})
