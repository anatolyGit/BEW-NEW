# encoding: utf-8
class ProjectsController < ApplicationController
  before_filter :parse_params, only: [:new, :create, :test,  :confirm]
  before_filter :authenticate_user, :get_status_list
 
  # project number
  @@project_number = ''
  def index
    @projects = Project.get_all_projects   
    @released_project = Project.get_released_projects
    
    respond_to do |format|         
      format.xls
      format.html
    end
  end

  def new
  	@whole_projects = Project.all
    if params[:id]
      @project = Project.find(params[:id])
    else
      @project = Project.new(params[:project] || {})
    end
 
    @start_time = Time.now
		respond_to do | format |
			format.js
		end 
  end

  def edit 
    id = params[:id]
    @project = Project.find( params[:id] )    
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
               
    @@project_number = @project.number
    @start_time = Time.now

    # if the user is not dir or super user 
    unless session[:user_authority] == 1
      redirect_to projects_path
    end   
  end

  def create
    case params[:commit]
    when '確認'
    	if params[:id]
      		@project = Project.find(params[:id])
      		@project.attributes = params[:project]
    	else
      	@project = Project.new(params[:project])
    	end
			@start_time = params[:track]
			@status = 'confirm'
	    respond_to do | format |
				format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
				format.js
			end
    when '再編集'
      @project = Project.new(params[:project]) 
			@start_time = params[:track] 
      @status = 're-edit'
      respond_to do | format |
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.js
      end
    when '一時保存'
    	@status = "draft"
      @project = Project.new(params[:project])
      @project.draft = 1
      @project.working = 0
      @project.user_id =current_user.id
      @project.save(validate: false)

			work = Work.new

      if params.has_key?(:progress)
				status = Status.find_by_name(params[:progress])
				@project.pa_links.create(status_id: status.id)
			else
				@project.pa_links.create(status_id: 1)
			end
			work.pa_link_id = @project.pa_links.last.id
			work.track = get_track(params[:track])
			work.save

			respond_to do | format |
				format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
				format.js
			end
    when '作成' 
    	@status = "save"
 
      if params[:id]
        @project = Project.find(params[:id])
      else
        @project = Project.new(params[:project])

        @project.user_id =current_user.id
        @project.draft = 0
        @project.working = 0
        unless @project.save
          logger.warn @project.errors.full_messages

          return render action: :new
        end
      end

      
      if params.has_key?(:progress)
				status = Status.find_by_name(params[:progress])
				@project.pa_links.create(status_id: status.id)
			else
				@project.pa_links.create(status_id: 1)
			end

			#save the track
			work = Work.new
			work.pa_link_id = @project.pa_links.last.id
			work.track = get_track(params[:track])
			work.save

      redirect_to '/projects/all'
    end
  end

  def destroy
      @project = Project.find(params[:id]) 
      @project.destroy
      redirect_to projects_path
  end 

  def update
    @project = Project.find(params[:id])     
    @project.update_attributes(params[:project])    
    pa_link = @project.pa_links.first
    if params.has_key?(:progress)
      pa_link.status_id = Status.find_by_name(params[:progress]).id
    else
      pa_link.status_id = 1        
    end
    pa_link.save
    return redirect_to projects_path
  end

  def working
      @project = Project.find(params[:id])
      @project.working = 0
      @project.save!
      render json: { working: @project.working }.to_json
  end
  # excel csv fromat (BOM + UTF8)
  def export  
    respond_to do |format|         
      format.xls { send_data "FFFFFFFF"}# { send_data @products.to_csv(col_sep: "\t") }
    end
=begin
    @projects = Project.get_released_projects 
    @filename = "All projects - #{Date.today.to_formatted_s(:db)}.csv"
    
    # Add BOM to make excel using utf8 to open csv file
    #head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join() 

    #headers = ["案件番号", '最終進捗（何稿までか）', 'リリース日','見込み工数（合算）', '作業工数（合算）', '画像作成工数（合算）', 'Wチェック工数（合算）', 'リリース前後工数（合算）']
    #headers = ["Project Number", "Recent Progress(Draft Count)", "Release Date","Estimation(SUM)", "Work Time(SUM)", "Image Work Time(SUM)", "WCheck Time(SUM)", "Release Before Time(SUM)"] 
    headers = ["案件番号", "Recent Progress(Draft Count)", "Release Date","Estimation(SUM)", "Work Time(SUM)", "Image Work Time(SUM)", "WCheck Time(SUM)", "Release Before Time(SUM)"] 
    csv_string = CSV.generate do |csv|
      csv << headers
      @projects.each do |project|  #reading ation_id = 2, 5, 8        
        # 案件番号
        number = project.number
        # 最終進捗（何稿までか）
        #recent_progress = project.pa_links.work_count.count.to_s + "稿"
        recent_progress = project.pa_links.work_count.count.to_s + "Drafts"
        # リリース日
        release_date = project.release_date.strftime("%y-%m-%d-%I")
        
        # 見込み工数(合算)    
        e_sum = Project.get_estimations_for_work(project.id)  
        e_sum_r = 0
        unless e_sum.nil?
          e_sum_r = e_sum[0]['estimation']
        end
        # 作業工数（合算）
        w_sum = Project.get_track_for_work(project.id)
        w_sum_r = 0
        unless w_sum.nil?
          w_sum_r = w_sum[0]['track']
        end
        # 画像作成工数（合算）
        i_sum = Project.get_track_for_image(project.id)
        i_sum_r = 0
        unless i_sum.nil?
          i_sum_r = i_sum[0]['track']
        end

        # Wチェック工数（合算）
        c_sum = Project.get_track_for_wcheck(project.id)
        c_sum_r = 0
        unless c_sum.nil?
          c_sum_r = c_sum[0]['track']
        end
        # リリース前後工数（合算）
        r_sum = Project.get_track_for_release(project.id)         
        r_sum_r = 0
        unless r_sum.nil?
          r_sum_r = r_sum[0]['track']
        end

        csv << ["#{project.id}", "#{recent_progress}", "#{release_date}", "#{e_sum_r}", "#{w_sum_r}", "#{i_sum_r}", "#{c_sum_r}", "#{r_sum_r}"]

      end
    end  
      
    send_data csv_string, :type => 'text/csv;',
                          :filename => @filename
=end                      
  end

  def check_number
    number = params[:number]

    if @@project_number == number
      render text: "true"
    else
      unless Project.exists?( :number => number )
        render text: "true"
      else
        render text: "false"
      end
    end  
=begin
    unless project.blank?
      projects = Project.where('id != ?', project.id )  
    else
      render text: "true"
    end 
=end 
  end

  def all
    @type = "all"
    @projects = Project.get_all_projects
    respond_to do |format|
      format.js
    end
  end

  def amc
    @type = "amc"
    @projects = Project.where(:category => @type)
    respond_to do |format|
      format.js
    end
  end

  def int
    @type = "int"
    @projects = Project.where(:category => @type)
    respond_to do |format|
      format.js
    end
  end

  def wws
    @type = "wws"
    @projects = Project.where(:category => @type)
    respond_to do |format|
      format.js
    end
  end

  def etc
    @type = "etc"
    @projects = Project.where(:category => @type)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def release
    @projects = Project.get_released_projects

    respond_to do |format|
      format.js
      format.html
    end
  end
 BOM = "\377\376"  
private
  def convert_gb(str) 
    require 'iconv' 
    BOM + Iconv.iconv("UTF-8", str.to_s)  
  end  

  def parse_params
    return if (project = params[:project]).blank?

    %w(release_date submit_date testup).each do |field|
      next if project[field.to_sym].blank?
      if project[field.to_sym] =~ /(\d{2})-(\d{2})-(\d{2})-(\d{2})/
        year, mon, mday, hour = $1.to_i, $2.to_i, $3.to_i, $4.to_i
        year = year + 2000
        project[field.to_sym] = DateTime.new(year, mon, mday, hour)
      end
    end

    project[:estimation] = project[:estimation].to_f
  end

  def get_status_list
    lists = Status.all
    @status = Hash.new
    lists.each  do | status |
      @status[status.id] = status.name
    end

    @status
  end

  def get_track(start_time)
  	@end_time = Time.now
		track =  (@end_time - Time.parse(start_time)) / 3600
		track.round(2)
	end

end
