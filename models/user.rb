# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :activities
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
end
