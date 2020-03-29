json.set! :relationships do
  json.array! @relationships do |relationship|
    json.extract! relationship, :id, :user_id, :follow_id, :created_at
  end
end