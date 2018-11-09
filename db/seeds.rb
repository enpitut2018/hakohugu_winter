# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(name:'User1',email:'user1@gmail.com')
user2 = User.create!(name:'User2',email:'user2@gmail.com')

category1 = Category.create!(name:'研究')

template1 = Template.create!(title:'研究アイデア出しノート',user_id:1,category_id:1,scope:1)

q1 = Question.create!(qtext:'研究テーマ名',template_id:1)
q2 = Question.create!(qtext:'何が課題か',template_id:1)
q3 = Question.create!(qtext:'課題の背景',template_id:1)
q4 = Question.create!(qtext:'自分の提案　どう解決するか',template_id:1)
q5 = Question.create!(qtext:'関連研究　何が課題か',template_id:1)
q6 = Question.create!(qtext:'関連リンク',template_id:1)
q7 = Question.create!(qtext:'カテゴリ',template_id:1)
q8 = Question.create!(qtext:'自分の提案との差分',template_id:1)


#Contain.create!(template_id:template1.id,question_id:q1.id)
#Contain.create!(template_id:template1.id,question_id:q2.id)
#Contain.create!(template_id:template1.id,question_id:q3.id)
#Contain.create!(template_id:template1.id,question_id:q4.id)
#Contain.create!(template_id:template1.id,question_id:q5.id)
