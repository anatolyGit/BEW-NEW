# encoding: utf-8

class Project < ActiveRecord::Base
  attr_accessible :draft, :category, :content, :estimation, :name, :number, :release_date, :submit_date, :testup, :urls, :attached_file, :attached_file_cache, :working

  has_many :pa_links, dependent: :destroy
  belongs_to :user

  mount_uploader :attached_file, AttachedFileUploader

  validates :number, presence: true, uniqueness: true
	#validate :file_size

  def self.get_released_projects
    Project.includes(:pa_links).where("pa_links.status_id = 31")
  end

  def self.get_all_projects
    Project.all
  end

	def file_name
		read_attribute :attached_file
	end
  def self.categories
    {
      'amc' => 'AMC運用',
      'int' => 'INT運用',
      'wws' => 'WWS運用',
      'etc' => 'ETC'
    }
  end
  # CSV Download
  def self.export(projects) 
     
  end
    

  def self.categories_for_options
    categories.invert
  end 

  def self.get_estimations_for_work(id)      
      Project.connection.select("SELECT ROUND(SUM(pro.estimation) + project.estimation, 2) as estimation FROM projects project
                                    LEFT JOIN pa_links pa_link ON project.id = pa_link.project_id
                                    LEFT JOIN works pro ON pro.pa_link_id = pa_link.id
                                    WHERE project.id = #{id}")
  end

  def self.get_track_for_work(id)
      Project.connection.select( "SELECT ROUND(SUM(w.track),2) as track FROM works w
                                  LEFT JOIN pa_links pa ON w.pa_link_id = pa.id
                                  LEFT JOIN projects p ON pa.project_id = p.id
                                  WHERE p.id = #{id} AND 
                                    (  pa.status_id = 18 OR
                                    pa.status_id = 5 OR pa.status_id = 4) ")
  end 

  def self.get_track_for_image(id)
      Project.connection.select( "SELECT ROUND(SUM(w.track),2) as track FROM works w
                                  LEFT JOIN pa_links pa ON w.pa_link_id = pa.id
                                  LEFT JOIN projects p ON pa.project_id = p.id
                                  WHERE p.id = #{id} AND 
                                    ( pa.status_id = 16 OR
                                    pa.status_id = 10 OR pa.status_id = 9 )")       
  end

  def self.get_track_for_wcheck(id)
      Project.connection.select( "SELECT ROUND(SUM(w.track),2) as track FROM works w
                                  LEFT JOIN pa_links pa ON w.pa_link_id = pa.id
                                  LEFT JOIN projects p ON pa.project_id = p.id
                                  WHERE p.id = #{id} AND 
                                    ( pa.status_id = 21 OR pa.status_id = 22 )")
  end

  def self.get_track_for_release(id)
      Project.connection.select( "SELECT ROUND(SUM(w.track),2) as track FROM works w
                                  LEFT JOIN pa_links pa ON w.pa_link_id = pa.id
                                  LEFT JOIN projects p ON pa.project_id = p.id
                                  WHERE p.id = #{id} AND 
                                    ( pa.status_id = 29 OR pa.status_id = 30 OR pa.status_id = 14 OR pa.status_id = 31 )") 
  end

private
	def update_attached_file_attributes
    if attached_file.present? && attached_file_changed?
      self.file_size = asset.file.size
    end
  end
end
