<template>
  <div id="app">
    <div class="form-row mb-md-3">
      <div class="col">
        <input type="text" class="form-control" id="Input" :value="title" disabled="disabled">
      </div>
      <div class="col">
        <button type="button" class="btn btn-success" @click="saveNote">ノートを保存</button>
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
            <br>
            <br>
            <br>
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
                <button
                  @click="transmissionMessage"
                  type="button"
                  class="btn btn-success btn-block"
                >回答</button>
              </div>
              <div id="skipQuestion" class="col-sm-2 skipBox-col">
                <button @click="skipQuestion" type="button" class="btn btn-primary btn-block">スキップ</button>
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
      count_t: 0, //チュートリアル用カウント変数
      count_d: 0, //詳細を出す時のカウント変数
      count_e: 0, //例を出す時のカウント変数
      conversationLogs: [],
      tutorials: [
        "",
        "",
        "回答の一覧は回答の編集のタブをクリックすることでいつでも編集できます。",
        "質問の意味がわからない方は「くわしく」と回答欄に入力してください。私が質問の意図、意味をお答えします。",
        "他の回答例を参考にしたい、という場合には「例えば」と入力してくだされば、質問に対する回答例を提示させて頂きます。",
        "どうしても質問に答えられないという方はスキップボタンを押してください。その質問を飛ばして次の質問に行きます。",
        "これらの機能は「ヘルプ」と回答に入力することでいつでも見ることができます。",
        "長くなってきましたので、そろそろ始めましょうか。"
      ],
      tutorial_flag: true
    };
  },

  mounted: function() {
    let path = location.pathname.split("/");
    let documentNumber = path[2];
    axios
      .get(`/api/questions/${documentNumber}`)
      .then(res => {
        let that = this;
        return this.storeResponseInVue(res, that);
      })
      .then(stored => {
        let that = this;
        return this.new_MDE(that);
      })
      .then(MEDCreated => {
        let that = this;
        simplemde.codemirror.on("change", function() {
          that.note = simplemde.value();
        });
      });
  },

  methods: {
    //mounted のときに呼ばれる関数1
    storeResponseInVue: function(res, that) {
      return new Promise(function(resolve) {
        that.questions = res.data.questions;
        that.title = res.data.title;
        that.note = res.data.content;
        that.tutorials[0] =
          "こんにちは、私は" +
          res.data.temp_title +
          "です。あなたが" +
          res.data.topic +
          "について考えるサポートをさせて頂きます。会話を進めるには回答ボタンを押してください。チュートリアルをスキップしたい方はスキップボタンを押してください。";
        that.tutorials[1] =
          "これから私" +
          res.data.temp_title +
          "が" +
          res.data.topic +
          "について質問していきます。質問と、あなたが入力した回答はノートとして成形されます。質問は全部で" +
          that.questions.length +
          "問です。";
        if (that.note == null) {
          that.note = "";
        }
        that.conversationLogs.push({
          question: that.tutorials[0]
        });
        resolve();
      });
    },
    //mounted のときに呼ばれる関数2
    new_MDE: function(that) {
      return new Promise(function(resolve) {
        simplemde = new SimpleMDE({
          element: document.getElementById("MyID"),
          initialValue: that.note,
          forceSync: true, //エディタの入力値をdocument.getElementById("MyID").valueで取得できるようになる
          autofocus: true //エディタに自動フォーカスする
        });
        resolve();
      });
    },
    addAnswerToNote: function() {
      this.note +=
        `## Q${this.count + 1}` + this.questions[this.count].qtext + "\n";
      this.note += "\t" + this.answer + "\n";
      simplemde.value(this.note);
      setTimeout(function() {
        simplemde.codemirror.refresh();
      }, 1);
    },
    transmissionMessage: function() {
      //会話ログに解答を格納
      if (this.questions[this.count]) {
        this.$set(
          this.conversationLogs[
            this.count_t + this.count + this.count_d + this.count_e
          ],
          "answer",
          this.answer
        );
      }
      //チュートリアル中と本番の質問で場合分け
      if (this.tutorial_flag && this.count_t < this.tutorials.length) {
        //チュートリアル中は回答をノートに記録しない
        this.count_t += 1;
      } else {
        this.tutorial_flag = false;
        //特殊回答による分岐
        if (this.answer == "詳しく" || this.answer == "くわしく") {
          //詳しくorくわしくで詳細を表示
          this.conversationLogs.push({
            question: this.questions[this.count].qdetail
          });
          this.answer = "";
          this.count_d += 1;
          this.$nextTick(function() {
            this.scrollToEnd("#conversation");
          });
          return false;
        } else if (this.answer == "例えば" || this.answer == "たとえば") {
          //例えばorたとえばで例を表示
          this.conversationLogs.push({
            question: this.questions[this.count].example
          });
          this.answer = "";
          this.count_e += 1;
          this.$nextTick(function() {
            this.scrollToEnd("#conversation");
          });
          return false;
        } else {
          this.addAnswerToNote();
          this.answer = "";
          //次の質問に進める。
          this.count += 1;
        }
      }
      //次の質問を会話ログに格納
      if (this.questions[this.count]) {
        if (
          this.tutorial_flag == false ||
          this.count_t >= this.tutorials.length
        ) {
          this.conversationLogs.push({
            question: this.questions[this.count].qtext
          });
        } else {
          this.conversationLogs.push({
            question: this.tutorials[this.count_t]
          });
        }
      }

      if (this.questions.length == this.count) {
        this.conversationLogs.push({
          question: "この質問で終わりです"
        });
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
      if (this.tutorial_flag) {
        //チュートリアル中に押されたら、チュートリアルを中止
        this.tutorial_flag = false;
        this.count_t += 1;
      } else {
        //会話ログに「次の質問」と格納
        if (this.questions[this.count]) {
          this.$set(this.conversationLogs[this.count], "answer", "次の質問は?");
        }
        this.addSkipQuestionToNote();
        this.answer = "";
        //次の質問に進める。
        this.count += 1;
      }

      if (this.questions[this.count]) {
        this.conversationLogs.push({
          question: this.questions[this.count].qtext
        });
      }

      if (this.questions.length == this.count) {
        this.conversationLogs.push({
          question: "この質問で終わりです"
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
      setTimeout(function() {
        simplemde.codemirror.refresh();
      }, 1);
    },
    saveNote: function() {
      let document = this.note;
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
