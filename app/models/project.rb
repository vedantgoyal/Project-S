class Project < ActiveRecord::Base
  attr_accessible :body, :title, :target
  has_many :sponsors
end
