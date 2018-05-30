class CommentSerializer < ActiveModel::Serializer
  attributes :body, :user
end
