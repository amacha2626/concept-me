json.set! :notifications do
  json.array! @notifications do |notification|
    json.visitor  notification.visitor
    json.post     notification.post
    json.comment  notification.comment
    json.action   notification.action
    json.checked  notification.checked
  end
end