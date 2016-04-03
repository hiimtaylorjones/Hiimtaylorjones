# frozen_string_literal: true
class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published, :tagline, :create_at, :updated_at
  has_many :comments, serialzer: Api::V1::CommentSerializer
end
