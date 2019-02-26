# frozen_string_literal: true

class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu
end
