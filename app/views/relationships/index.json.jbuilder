json.set! :relationships do
  json.array! @relationships do |relationship|
    json.id relationship.id
    json.user_id relationship.user_id
    json.follow_id relationship.follow_id
    json.user relationship.user
    json.follow relationship.follow
    json.follow_post relationship.follow.posts
    json.created_at relationship.created_at
  end
end