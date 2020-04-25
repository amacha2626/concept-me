json.set! :likes do
  json.array! @likes do |like|
    json.id like.id
    json.post_id like.post_id
    json.user_id like.user_id
    json.image rails_blob_url(like.post.post_image) if like.post.post_image.attached?
    json.created_at like.created_at
  end
end