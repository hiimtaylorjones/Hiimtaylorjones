# frozen_string_literal: true
class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :name, :email, :message, :approved

  belongs_to :post
end
