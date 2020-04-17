json.set! :likes do
  json.array! @likes do |like|
    json.id like.id
    json.post_id like.post_id
    json.user_id like.user_id
    json.post like.post
    json.created_at like.created_at
  end
end