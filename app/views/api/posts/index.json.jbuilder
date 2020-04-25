# json.set! :posts do
#   json.array! @posts do |post|
#     json.extract! post, :id, :title, :image, :user_id, :created_at
#   end
# end

json.set! :posts do
  json.array! @posts do |post|
    json.id post.id
    json.title post.title
    json.image rails_blob_url(post.post_image) if post.post_image.attached?
    json.user_id post.user_id
    json.post_likes post.likes
    json.created_at post.created_at
  end
end