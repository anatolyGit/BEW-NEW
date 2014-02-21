# encoding: utf-8
class WorksController < ApplicationController	
	before_filter :authenticate_user, :get_status_list
	after_filter :set_working, :only => :progress

	def create
		@project = Project.find(params[:project_id])		
		pa_link = PaLink.new

		if params.has_key?(:process)
			status = Status.find_by_name(params[:process])
			pa_link.status_id = status.id
		end	
		pa_link.project_id = params[:project_id]
		pa_link.save!

		unless params[:release_before_request].blank?
			if params.has_key?(:release) 
				work = Work.new(params[:release])
				work.pa_link_id = pa_link.id

				# track
				work.track = get_track(params[:track])
				work.save!
			end
		else
			work = Work.new(params[:work])
			work.pa_link_id = pa_link.id

			# track
			work.track = get_track(params[:track])
			work.save!
		end 
		unless pa_link.work.release_date.blank?
			@project.release_date = pa_link.work.release_date
		end

		unless pa_link.work.submit_date.blank?
			@project.submit_date = pa_link.work.submit_date
		end

		unless pa_link.work.testup.blank?
			@project.testup = pa_link.work.testup
		end

		@project.working = 0 
		@project.save!

		@id = params[:project_id]
		@last_id = @project.pa_links.last.status_id
		respond_to do | format |
			format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
			format.js
		end
	end

	def destroy
	end 
	
	def update 
		# get the selected project
		@project = Project.find(params[:project_id])

		# get the current progress
		@new_action = @project.pa_links.last.work
		@new_action.attributes = params[:work]
		# calculate the track
		track = get_track(params[:track])
		@new_action.update_attributes(:track => @new_action.track + track )
		# update the progress
		@new_action.save!
		# update the action
		if params.has_key?(:process)
			status = Status.find_by_name(params[:process])
			@project.pa_links.last.update_attributes(:status_id => status.id)
			@project.pa_links.last.save!
		end
		
		@id = params[:project_id] 
		respond_to do | format |
			format.js
		end
	end

	def progress
		@project = Project.find(params[:id])  
		@work_count = @project.pa_links.work_count.count 
		
		if @project.pa_links.work_charge.present?
	      @work_charge_name = @project.pa_links.work_charge.work.charge_name	      
	    else
	      @work_charge_name = "" 
	    end

	    if @project.pa_links.wcheck_name.present?
	    	@wcheck_name = @project.pa_links.wcheck_name.work.check_name
	    else
	    	@wcheck_name = ""
	    end	

		if @project.pa_links.last.status_id == 18 || 
		   @project.pa_links.last.status_id == 10 ||  # 作業ストップ 
		   @project.pa_links.last.status_id == 4      # 作業ストップ wcheck
		   @pa_link = @project.pa_links.last
	 	   @new_action = Work.find(@pa_link.work.id)   
		else
			@pa_link =  PaLink.new
			@new_action = Work.new
		end

		@start_time = Time.now
		respond_to do | format |
			format.js
		end
	end

private
	def set_working 
		@project.working = 1
		@project.save!  
	end

	def working_status
		# change working status on the page list
		project = Project.find(params[:id])
		project.working = project.pa_links.last.status_id
		project.save
	end

	def get_track(start_time)
  		@end_time = Time.now
		track =  (@end_time - Time.parse(start_time)) / 3600
		track.round(2)
	end

	def get_status_list
    lists = Status.all
    @status = Hash.new
    lists.each  do | status |
      @status[status.id] = status.name
    end

    @status
  end
end

