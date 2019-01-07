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
json.count_called_h @document.count_called_h
json.sum_h @document.sum_h
json.image_path1 @image_path1
json.image_path2 @image_path2
json.user_name @document.user.name



