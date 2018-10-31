<template>
  <div id = "app">
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Cogito</a>
      <input class="form-control form-control-dark w-100" type="text" placeholder="検索" aria-label="検索">
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
          <a class="nav-link" href="#">サインアウト</a>
        </li>
      </ul>
    </nav>


    <div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <ul class="nav flex-column">
              <li class="nav-item">
                <a class="nav-link active" href="#">
                  <span data-feather="home"></span>
                  Ayaka Ebisu<span class="sr-only"></span>
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="home"></span>
                  大学 <span class="sr-only">(現位置)</span>
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file"></span>
                  研究
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="shopping-cart"></span>
                  研究１
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="users"></span>
                  研究２
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="bar-chart-2"></span>
                  授業
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="layers"></span>
                  お金
                </a>
                <hr>
              </li>
            </ul>

            <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
              <span>保存されたレポート</span>
              <a class="d-flex align-items-center text-muted" href="#">
                <span data-feather="plus-circle"></span>
              </a>
            </h6>
            <ul class="nav flex-column mb-2">
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  今月
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  前四半期
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  社会的関与
                </a>
                <hr>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  年末販売

                </a>
                <hr>
              </li>
            </ul>
          </div>
        </nav>

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
