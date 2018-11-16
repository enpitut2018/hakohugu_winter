# coding: utf-8
json.array! @questions do |question|
   json.qtext question.qtext
   json.qdetail question.qdetail
   json.example question.example
end
