# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:'Admin',email:'admin_cogito@gmail.com', password: "caodgmiitno", password_confirmation: "caodgmiitno", admin: true)
User.create!(name:'User1',email:'user1@gmail.com', password: "foobar", password_confirmation: "foobar")
User.create!(name:'Unknown',email:'user2@gmail.com', password: "foobar", password_confirmation: "foobar")
Category.create!(name:'研究')
Category.create!(name:'自己分析')

Template.create!(title:'研究テーマ決定支援アシスタント',user_id:1,category_id:1,scope:1,topic:'研究テーマをまとめます。')
Template.create!(title:'自己分析アシスタント',user_id:1,category_id:1,scope:1,topic:'自分の興味の対象にフォーカスを当てて自己分析をします。')

Document.create!(title:'研究アイデア',user_id:1,template_id:1,scope: 0,content: nil)
Document.create!(title:'自己分析',user_id:1,template_id:2,scope: 0,content: nil)


Question.create!(qtext:'1 あなたの研究分野は何ですか？',template_id:1,qdetail:'あなたが取り組もうと考えている分野を教えてください。',example:'')
Question.create!(qtext:'2 なぜその分野に興味を持ったのでしょうか？その理由になるような特に興味のある単語を二つ、三つ挙げてみましょう。',template_id:1,qdetail:'',example:'')
Question.create!(qtext:'3 それではその単語をcinii・Googlescholor等で調べてみましょう。参考になりそうな論文を見つけたらそのタイトルと関連語を2つ、３つ挙げてみましよう。',template_id:1,qdetail:'',example:'')
Question.create!(qtext:'4 その中から三つキーワードをピックアップしてもう一度検索してみましょう。参考になりそうな論文のタイトルを入力してみてください。',template_id:1,qdetail:'',example:'')
Question.create!(qtext:'5 調べた論文の中から、あなたの研究の先行事例となりそうな論文のタイトルをあげてみましょう。',template_id:1,qdetail:'',example:'')
Question.create!(qtext:'6 先行事例の限界や問題点を考えてみましょう。',template_id:1,qdetail:'',example:'')
Question.create!(qtext:'7 6で挙げた先行事例の問題点に対する解決策の仮説を立ててみましょう。',template_id:1,qdetail:'',example:'')
Question.create!(qtext:'8 では、質問6,7の回答をもとにしてあなたの研究の方針を決めましょう。書き方は「私は『研究分野』における『問題点』に対する『解決策』の研究をします。」です。',template_id:1,qdetail:'',example:'')


Question.create!(qtext:'自分が今興味を持ってるものはなんですか',template_id:2,qdetail:'まずはどんな領域のことでも自由に書いてみましょう',example:'構造色、物理的な構造による発色の原理')
Question.create!(qtext:'なぜ興味を持っていますか？',template_id:2,qdetail:'興味を持つきっかけとなった出来事やエピソードを書いてみましょう',example:'物理で勉強した光の干渉が美しい色を発色する構造色の原理の一つになっていることに感動した。構造色の発色は鮮やかですき。構造色を持つ，モルフォ蝶やカワセミ，オパールが好きだった。')
Question.create!(qtext:'いつから興味を持っていますか？',template_id:2,qdetail:'興味を持った時の自分の年齢や経過を思い出してみましょう',example:'子供の頃から色は自分にとって重要なトピックだった。小さい頃は好きな色がなくて，そのことを不思議に思っていた。中高生の頃になって青系の色が好きなことに気がついた。それからはいろんな色の魅力があることに気づくようになった。')
Question.create!(qtext:'子供(小学生まで)の頃すきだったものはなんですか？',template_id:2,qdetail:'次は今ではなく、小学生までに好きだったものについて考えてみましょう',example:'推理小説・クイズ・パズル')
Question.create!(qtext:'どこがすきですか？',template_id:2,qdetail:'好きなところを自由に挙げてみましょう',example:'一つ一つ手がかりを探して，共通点や異質な点を見出して，だんだんと答えに迫っていく過程。')
Question.create!(qtext:'なぜそれがすきですか？',template_id:2,qdetail:'すきになったきっかけを思い出してみましょう',example:'頭を使って考えたことが，合っているとうれしい。探偵って，みんなが気づかないことを気づいていてかっこいいって思ってた。')
Question.create!(qtext:'中高生の頃すきだったものはなんですか？',template_id:2,qdetail:'今度は少し進んで、中高生の頃を思い出してみましょう',example:'音楽　特にSax，Mili')
Question.create!(qtext:'どこがすきですか？',template_id:2,qdetail:'好きなところを自由に挙げてみましょう',example:'音楽：自分の感情を表現したり，コントロールしたりするのに役立つところ。Sax：いろんなジャンルの曲で様々な表情を見せられる。音に艶がある。人間の声に近い。Mili：ボーカルの声が好きだった。世界観に共感できる。')
Question.create!(qtext:'なぜそれががすきですか？',template_id:2,qdetail:'すきになったきっかけを思い出してみましょう',example:'"音楽：歌ったり演奏してると楽しくなる。Sax：楽器なのに人間が歌ってるように聞こえる。ビジュアルがかっこいい。先輩の演奏がかっこよかったから。Mili：ボーカルはトリリンガルで多彩だし，透き通った声は自分にないものだったから。単に明るいだけでなく，暗さも持つ世界観に共感した。')
Question.create!(qtext:'これまでに挙げた自分の好きなものや興味ついて共通点・キーワードはありますか？',template_id:2,qdetail:'ノートを見直してみて、共通する部分がないか探してみましょう',example:'小さい頃はロジカルなものが好きだったけど，音楽とか色とか芸術的な要素のあるものにも興味を持つようになった。')


#Contain.create!(template_id:template1.id,question_id:q1.id)
#Contain.create!(template_id:template1.id,question_id:q2.id)
#Contain.create!(template_id:template1.id,question_id:q3.id)
#Contain.create!(template_id:template1.id,question_id:q4.id)
#Contain.create!(template_id:template1.id,question_id:q5.id)
