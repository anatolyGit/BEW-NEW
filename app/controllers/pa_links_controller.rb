# encoding: utf-8
class PaLinksController < ApplicationController
	before_filter :authenticate_user #:working_status
	def create
		# save the current progress
		pa_link = PaLink.new
		if params.has_key?(:process)
			status = Status.find_by_name(params[:process])
			pa_link.status_id = status.id
		end

		pa_link.project_id = params[:project_id]
		pa_link.save!
		# upload file
		work = Work.new
		file = params[:pa_link]
		work.pa_link_id = pa_link.id
		unless file.blank?
			work.attached_file = file["attached_file"]
		end
		work.save!
		redirect_to projects_path
	end

	def update
		# change the prgores
		pa_link = PaLink.find(params[:id])
		if params.has_key?(:process)
			status = Status.find_by_name(params[:process])
			pa_link.status_id = status.id
		end
		pa_link.save!
		# update the work
		work = pa_link.work
		work.update_attributes(params[:pa_link])
		@project = Project.find(params[:project_id]) 
		# active to 中断 status
		@project.working = 0
		@project.save!

		redirect_to projects_path
	end

	def destroy		
		pa_link = PaLink.find(params[:id])
		@project = Project.find(pa_link.project_id) 		
		PaLink.destroy_all("id > #{params[:id]} AND project_id = #{pa_link.project_id}")
      	redirect_to projects_path
	end 

	def index
	end	
private
	def working_status
		# After the working was done, it should be empty
		#project = Project.find(params[:id])
		#project.working = ''
		#project.save
	end
end
