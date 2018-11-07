# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(name:'User1',email:'user1@gmail.com')
user2 = User.create!(name:'User2',email:'user2@gmail.com')

q1 = Question.create!(qtext:'研究テーマ名')
q2 = Question.create!(qtext:'何が課題か')
q3 = Question.create!(qtext:'課題の背景')
q4 = Question.create!(qtext:'自分の提案　どう解決するか')
q5 = Question.create!(qtext:'関連研究　何が課題か')
q6 = Question.create!(qtext:'関連リンク')
q7 = Question.create!(qtext:'カテゴリ')
q8 = Question.create!(qtext:'自分の提案との差分')

category1 = Category.create!(name:'研究')

template1 = Template.create!(title:'研究アイデア出しノート',user_id:user1.id,category_id:category1.id,scope:1)

Contain.create!(template_id:template1.id,question_id:q1.id)
Contain.create!(template_id:template1.id,question_id:q2.id)
Contain.create!(template_id:template1.id,question_id:q3.id)
Contain.create!(template_id:template1.id,question_id:q4.id)
Contain.create!(template_id:template1.id,question_id:q5.id)
