<template>
<div id = "app">
  <div class="form-row mb-md-3">
    <div class="col">
      <input type="text" class="form-control" id="Input" :value="title" disabled="disabled"> 
    </div>
    <div class="col">
      <button type="button" class="btn btn-success" @click="saveNote" >ノートを保存</button>
    </div>
  </div>

  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a href="#tab1" @click="viewChange" class="nav-link active" data-toggle="tab">質問に答える</a>
    </li>
    <li class="nav-item">
      <a href="#tab2" @click="viewChange" class="nav-link" data-toggle="tab">回答の編集</a>
    </li>
  </ul>

  <div class="tab-content">
    <div id="tab1" class="tab-pane active">
      <div id="conversation">
        <template v-if="questions" v-for="conversationLog in conversationLogs">
          <div class="question-balloon">
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

        <!-- 回答ボタンの横に次の質問へスキップするボタンを追加 -->
      <div id="transmission">
        <div class="transmissionBox">
          <div class="row">
            <div id="transmissionMessage" class="col-sm-10 messageBox-col">
              <button @click="transmissionMessage" type="button" class="btn btn-success btn-block">回答</button>
            </div>
            <div id="skipQuestion" class="col-sm-2 skipBox-col">
              <button @click="skipQuestion" type="button" class="btn btn-primary btn-block">Skip</button>
            </div>
          </div>
        </div>
      </div>

    </div>

    <div id="tab2" class="tab-pane">
      <textarea id="MyID"></textarea>
    </div>
  </div>
</div>
</template>


<script>
import axios from "axios";
import SimpleMDE from "simplemde";
import { csrfToken } from "rails-ujs";
import swal from "sweetalert";

//axiosでPOSTを送るときのCSRF対策のトークンをrails-ujsを使って作成
axios.defaults.headers.common["X-CSRF-Token"] = csrfToken();
var simplemde;

export default {
  data: () => {
    return {
      title: "",
      answer: "",
      note: "",
      questions: "",
      count: 0,
      count_t: 0,
      conversationLogs: [],
      tutorials: [
        '',
        '',
        '回答の一覧はノートの編集のタブをクリックすることでいつでも編集できます。',
        '質問の意味がわからない方は「くわしく」と回答欄に入力してください。私が質問の意図、意味をお答えします。',
        '他の回答例を参考にしたい、という場合には「例えば」と入力してくだされば、質問に対する回答例を提示させて頂きます。',
        'どうしても質問に答えられないという方はスキップボタンを押してください。その質問を飛ばして次の質問に行きます。',
        'これらの機能は「ヘルプ」と回答に入力することでいつでも見ることができます。',
        '長くなってきましたので、そろそろ始めましょうか。'
      ],
      note_flag: false
    };
  },

  created: function() {
    let path = location.pathname.split("/");
    let documentNumber = path[2];

    axios.get(`/api/questions/${documentNumber}`).then(res => {
      this.questions = res.data.questions;
      this.title = res.data.title;
      this.note = res.data.content;
      this.tutorials[0] = 'こんにちは、私は' + res.data.temp_title + 'です。あなたが' + res.data.topic + 'について考えるサポートをさせて頂きます。会話を進めるには送信ボタンを押してください。チュートリアルをスキップしたい方はskipボタンを押してください。';
      this.tutorials[1] = 'これから私' + res.data.temp_title + 'が' + res.data.topic + 'について質問していきます。質問と、あなたが入力した回答はノートとして成形されます。質問は全部で' + this.questions.length + '問です。';
      if (this.note == null) {
        this.note = "";
      }
      this.conversationLogs.push({
        question: this.tutorials[0]
      });
    });
  },

  methods: {
    addAnswerToNote: function() {
      this.note +=
        `## Q${this.count + 1}` + this.questions[this.count].qtext + "\n";
      this.note += "\t" + this.answer + "\n";
    },
    transmissionMessage: function() {
      //会話ログに解答を格納
      if (this.questions[this.count]) {
        this.$set(this.conversationLogs[this.count+this.count_t], "answer", this.answer);
      }
      if (this.count_t>=this.tutorials.length){
        this.addAnswerToNote();
        this.answer = "";
        //次の質問に進める。
        this.count += 1;
      }else{
        this.count_t +=1 ;
      }
      if (this.questions[this.count]) {
        if (this.count_t>=this.tutorials.length){
          this.conversationLogs.push({
            question: this.questions[this.count].qtext
          });
        }else{
          this.conversationLogs.push({
            question: this.tutorials[this.count_t]
          });
        }
      }
      /* スクロール位置を更新*/
      this.$nextTick(function() {
        this.scrollToEnd("#conversation");
      });
    },
    /*質問を飛ばす時に行う処理*/
    addSkipQuestionToNote: function() {
      this.note +=
        `## Q${this.count + 1}` + this.questions[this.count].qtext + "\n";
      this.note += "\t" + "" + "\n";
    },
    skipQuestion: function() {
      //会話ログに「次の質問」と格納
      if (this.questions[this.count]) {
        this.$set(this.conversationLogs[this.count], "answer", "次の質問は?");
      }
      this.addSkipQuestionToNote();
      this.answer = "";
      //次の質問に進める。
      this.count += 1;

      if (this.questions[this.count]) {
        this.conversationLogs.push({
          question: this.questions[this.count].qtext
        });
      }
      /* スクロール位置を更新*/
      this.$nextTick(function() {
        this.scrollToEnd("#conversation");
      });
    },
    /*質問飛ばす処理ここまで*/

    scrollToEnd: function(query) {
      var container = document.querySelector(query);
      container.scrollTop = container.scrollHeight;
    },
    viewChange: function() {
      if (this.note_flag == false) {
        simplemde = new SimpleMDE({
          element: document.getElementById("MyID"),
          forceSync: true, //エディタの入力値をdocument.getElementById("MyID").valueで取得できるようになる
          autofocus: true //エディタに自動フォーカスする
        });
        simplemde.value(this.note);
        setTimeout(function() {
          simplemde.codemirror.refresh();
        }, 1);
        this.note_flag = true;
      } else {
        simplemde.value(this.note);
        setTimeout(function() {
          simplemde.codemirror.refresh();
        }, 1);
      }
    },
    saveNote: function() {
      if (this.note_flag == false) {
        this.viewChange();
      }

      let document = simplemde.value();
      axios
        .patch("", {
          content: document
        })
        .then(function(response) {
          swal("Complete!", "ノートの保存が完了しました。", "success");
        })
        .catch(error => {
          swal(
            "Oops!",
            "ノートの保存に失敗しました。もう一度お試しください",
            "error"
          );
        });
    }
  }
};
</script>
