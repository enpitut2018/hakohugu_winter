# coding: utf-8
json.questions do
   json.array! @questions, :qtext,:qdetail,:example 
end
json.title @document.title
json.content @document.content


