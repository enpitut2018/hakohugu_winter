# coding: utf-8
json.questions do
   json.array! @questions, :qtext,:qdetail,:example 
end
json.title @document.title
json.content @document.content
json.temp_title @template.title
json.topic @template.topic
json.conversation_logs @document.conversation_logs
json.question_number @document.question_number
json.count_t @document.count_t
json.count_d @document.count_d
json.count_e @document.count_e



