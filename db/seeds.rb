# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:'User1',email:'user1@gmail.com')
User.create!(name:'User2',email:'user2@gmail.com')
Category.create!(name:'研究')

Template.create!(title:'研究アイデア出しノート',user_id:1,category_id:1,scope:1)
Template.create!(title:'自己分析',user_id:1,category_id:1,scope:1)


Question.create!(qtext:'研究テーマ名',template_id:1,qdetail:'興味のあるテーマを書いてみましょう',example:'電気刺激によるリズム学習')
Question.create!(qtext:'何が課題か',template_id:1)
Question.create!(qtext:'課題の背景',template_id:1)
Question.create!(qtext:'自分の提案　どう解決するか',template_id:1)
Question.create!(qtext:'関連研究　何が課題か',template_id:1)
Question.create!(qtext:'関連リンク',template_id:1)
Question.create!(qtext:'カテゴリ',template_id:1)
Question.create!(qtext:'自分の提案との差分',template_id:1)

Question.create!(qtext:'自分が今興味を持ってるものはなんですか',template_id:2,qdetail:'まずはどんな領域のことでも自由に書いてみましょう',example:'構造色、物理的な構造による発色の原理')
Question.create!(qtext:'なぜ興味を持っていますか？',template_id:2)
Question.create!(qtext:'いつから興味を持っていますか？',template_id:2)
Question.create!(qtext:'子供(小学生まで)の頃すきだったものはなんですか？',template_id:2)
Question.create!(qtext:'どこがすきですか？',template_id:2)
Question.create!(qtext:'なぜそれがすきですか？',template_id:2)
Question.create!(qtext:'中高生の頃すきだったものはなんですか？',template_id:2)
Question.create!(qtext:'どこがすきですか？',template_id:2)
Question.create!(qtext:'なぜそれががすきですか？',template_id:2)
Question.create!(qtext:'これまでに挙げた自分の好きなものや興味ついて共通点・キーワードはありますか？',template_id:2)


#Contain.create!(template_id:template1.id,question_id:q1.id)
#Contain.create!(template_id:template1.id,question_id:q2.id)
#Contain.create!(template_id:template1.id,question_id:q3.id)
#Contain.create!(template_id:template1.id,question_id:q4.id)
#Contain.create!(template_id:template1.id,question_id:q5.id)
