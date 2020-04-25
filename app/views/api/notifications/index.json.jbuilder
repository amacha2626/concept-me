json.set! :notifications do
  json.array! @notifications do |notification|
    json.id       notification.id
    json.visitor  notification.visitor
    json.post     notification.post
    json.comment  notification.comment
    json.action   notification.action
    json.checked  notification.checked
    json.time     notification.created_at.strftime("%Y-%m-%d %H:%M")
  end
end