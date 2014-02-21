class Status < ActiveRecord::Base
  attr_accessible :name

  has_many :pa_link
end
