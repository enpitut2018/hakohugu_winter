<template>
  <div class="row">

    <div v-show="page_id == 0" class="col-md-8">
      <div id="conversation">
        <template v-if="questions" v-for="conversationLog in conversationLogs">
          <div class="question-balloon" >
            <p>{{conversationLog.question}}</p>
          </div>
          <br>
          <div v-if="conversationLog.answer" class="answer-balloon float-right">
            <p>{{conversationLog.answer}}</p>
          </div>
          <br><br><br>
        </template>
      </div>
      
      <div id="inputText">
        <textarea v-model="answer" placeholder="解答を入力" style="width:100%;height:100%;"></textarea>
      </div>
      <div id="transmissionMessage" class="border">
        <button @click="transmissionMessage" type="button" class="btn btn-success btn-block">send</button>
      </div>
    </div>

    <div v-show="page_id == 1" class="col-md-8" id="noteArea">
      <textarea id="MyID"></textarea>
    </div>

    <div class="col-md-4 border">
      <div class="menu-list" style="m">
        <p class="text-center">Voice over</p>
        <p class="text-center">Record</p>
        <p class="text-center">Play / Stop</p>
        <p v-if="page_id == 0" @click="viewChange"　class="text-center">View</p>
        <p v-if="page_id == 1" @click="viewChange" class="text-center">戻る</p>
        
        <p class="text-center">Save</p>
      </div>
    </div>

  </div>



</template>


<script>
 import axios from 'axios'
 import SimpleMDE from 'simplemde'

 export default {
   data: () => {
     return {
       answer: "",
       note: "",
       questions: "",
       count: 0,
       conversationLogs: [],
       page_id: 0,
       note_flag: false
     }
   },

   created: function () {
     //変数argにgetメソッドのパラメータを格納
     //arg.template_idとしてアクセス。
     var arg = new Object;
     var pair=location.search.substring(1).split('&');
     for(var i=0;pair[i];i++) {
       var kv = pair[i].split('=');
       arg[kv[0]]=kv[1];
     }

     axios.get(`api/questions/${arg.template_id}`)
          .then(res => {
            this.questions = res.data;
            this.conversationLogs.push({question: this.questions[0].qtext});
          });
   },

   methods: {
     addAnswerToNote: function (){
       this.note += (`Q${this.count+1}` + this.questions[this.count].qtext + "\n")
       this.note += ("\t" + this.answer + "\n")
     },
     transmissionMessage: function(){
       //会話ログに解答を格納
       if(this.questions[this.count]){
         this.$set(this.conversationLogs[this.count],"answer", this.answer)
       }
       this.addAnswerToNote()
       this.answer=""
       //次の質問に進める。
       this.count += 1

       if(this.questions[this.count]){
         this.conversationLogs.push({question: this.questions[this.count].qtext})
       }
       /* スクロール位置を更新*/
       this.$nextTick(function() {
         this.scrollToEnd("#conversation")
       })
     },
     scrollToEnd: function(query){
       var container = document.querySelector(query)
       container.scrollTop = container.scrollHeight
     },
     viewChange: function(){
      if(this.page_id==0){
        this.page_id = 1
        if(this.note_flag==false){
          var simplemde = new SimpleMDE({ element: document.getElementById("MyID") })
          this.note_flag = true
        }
       }
      else{
        this.page_id = 0
      }
     }
   }
 }
</script>
