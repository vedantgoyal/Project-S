class Sponsor < ActiveRecord::Base
  attr_accessible :amount, :name, :project_id
  belongs_to :project
	validates_numericality_of :amount, :only_float => true
end
