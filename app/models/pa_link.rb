class PaLink < ActiveRecord::Base
  attr_accessible :project_id, :status_id
  has_one :work,  dependent: :destroy
  belongs_to :project
  belongs_to :status

  def self.work_count
  	where( "status_id < 3")
  end

  
  def self.work_charge
    where("status_id = 5 OR status_id = 18").first
  end

  def self.wcheck_name
    where("status_id = 21 OR status_id=22").last
  end
end
