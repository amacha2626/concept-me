json.set! :posts do
  json.array! @posts do |post|
    json.extract! post, :id, :title, :image, :user_id, :created_at
  end
end