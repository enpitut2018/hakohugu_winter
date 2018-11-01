<template>

  <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
    <div class="row">
      <div class="col-md-8">
        <div class="form-group">
          <label for="exampleFormControlTextarea1">エディタ</label>
          <textarea v-model="note" class="form-control" id="exampleFormControlTextarea1" rows="37"></textarea>
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-group">

          <label for="exampleFormControlTextarea1">Answer</label>
          <textarea v-model="answer" class="form-control" id="exampleFormControlTextarea1" rows="12"></textarea>
        </div>
        <div class="form-group">
          <button  @click='addAnswerToNote' class="btn btn-primary btn-lg btn-block">回答</button>

        </div>
        <div class="card">
          <div class="card-header">
            質問
          </div>
          <div class="card-body">
            <h5 class="card-title">Q{{this.count+1}}</h5>
            <p class="card-text" v-if="question">{{question[this.count].qtext}}</p>
          </div>
        </div>
        <br>
        <div class="card">
          <div class="card-header">
            カードのヘッダ
          </div>
          <div class="card-body">
            <h5 class="card-title">カードのタイトル</h5>
            <p class="card-text">以下のテキストを追加のコンテンツへの自然な導入としてサポート。</p>
            <a href="#" class="btn btn-primary">ボタン</a>
            <br><br>
          </div>
        </div>
      </div>
    </div>
  </main>
    </div><!-- /.table-responsive -->
    </div>

</template>


<script>
 import axios from 'axios';

 //変数argにgetメソッドのパラメータを格納
 //arg.template_idとしてアクセス。
 var arg = new Object;
 var pair=location.search.substring(1).split('&');
 for(var i=0;pair[i];i++) {
   var kv = pair[i].split('=');
   arg[kv[0]]=kv[1];
 }


 export default {
   data: () => {
     return {
       answer: "",
       note: "",
       question: "",
       count: 0
     }
   },

   created: function () {
     axios.get(`api/questions/${arg.template_id}`)
          .then(res => {
            this.question = res.data;
          });
   },

   methods: {
     addAnswerToNote: function (){
       this.note += ("Q" + this.question[this.count].qtext);
       this.note += "\n";
       this.note += this.answer;
       this.note += "\n";
       this.answer = "";
       this.count += 1;
     }
   }
 }
</script>
