class Work < ActiveRecord::Base
  attr_accessible :pa_link_id, :appended, :contact, :deleted_at, :estimation, :jobs, :release_date, :charge_name, :track, :updated_user_id, :urls, :attached_file, :attached_file_cache, :check_name, :submit_date, :testup

  belongs_to :pa_link
  mount_uploader :attached_file, AttachedFileUploader

  def file_name
		read_attribute :attached_file
	end
end
