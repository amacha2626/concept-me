json.id         @post.id
json.title      @post.title
json.image      @post.image
json.user_name  @post.user.name
json.user_id    @post.user.id
json.comments @comments do |comment|
  json.comment_id comment.id
  json.comment_content comment.content
  json.comment_user comment.user
end