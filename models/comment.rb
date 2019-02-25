# frozen_string_literal: true

class Comment < ActiveRecord::Base
  validates :body, presence: true
end
