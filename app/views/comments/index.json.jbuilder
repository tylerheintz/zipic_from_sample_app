json.array!(@comments) do |comment|
  json.extract! comment, :content, :user_id, :micropost_id, :rating
  json.url comment_url(comment, format: :json)
end