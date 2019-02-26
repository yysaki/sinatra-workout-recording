# frozen_string_literal: true

class Menu < ActiveRecord::Base
  belongs_to :category
  has_many :activities
  validates :name, presence: true
  validates :level, presence: true
end
