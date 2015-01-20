class Sponsor < ActiveRecord::Base
  attr_accessible :amount, :name, :project_id
  belongs_to :project
end
