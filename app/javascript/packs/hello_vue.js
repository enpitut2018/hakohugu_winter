import Vue from 'vue/dist/vue.esm'
import axios from 'axios';


document.addEventListener('DOMContentLoaded', () => {

  //変数argにgetメソッドのパラメータを格納
  //arg.template_idとしてアクセス。
  var arg = new Object;
  var pair=location.search.substring(1).split('&');
  for(var i=0;pair[i];i++) {
    var kv = pair[i].split('=');
    arg[kv[0]]=kv[1];
  }


  //ここからvueインスタンス
  const app = new Vue({
    el: '#app',
    data: {
      answer: "",
      note: "",
      question: "",
      count: 0
    },

    mounted: function () {
      axios.get(`api/questions/${arg.template_id}`)
           .then(res => {
             this.question = res.data;
           });
    },

    methods: {
      addAnswerToNote: function (){
        this.note += ("Q" + this.question[this.count].qtext)
        this.note += "\n"
        this.note += this.answer
        this.note += "\n"
        this.answer = ""
        this.count += 1
      }
    }
  })
})
