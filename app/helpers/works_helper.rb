module WorksHelper
	def popup_title(status_id, work_count, previous_status = 0 )
		if current_action(status_id) == 17  
			if work_count == 1
				image_tag 'popup/tit_h1_img_files_preparation.gif', alt: '画像等・準備中', width: 235, height: 35
			else
				"画像等準備(" + work_count.to_s + "稿依頼)中"
			end 
		elsif current_action(status_id) == 5
			image_tag 'popup/tit_h1_wcheck.gif', alt: 'Wチェック中', width: 235, height: 35
		elsif current_action(status_id) == 16
			if work_count == 1
				image_tag 'popup/tit_h1_first_work.gif', alt: '初稿作業中', width: 235, height: 35
			else
				work_count.to_s + "稿作業中"
			end
		elsif current_action(status_id) == 19 #中断
			if previous_status == 9
				"内校戻し作業中" 	
			else
				image_tag 'popup/tit_h1_first_work.gif', alt: '初稿修正作業中', width: 235, height: 35 
			end	
		elsif current_action(status_id) == 3 #中断
			image_tag 'popup/tit_h1_first_work.gif', alt: '初稿修正作業中', width: 235, height: 35 	
		elsif current_action(status_id) == 21 #修正アリ
			if work_count == 1
				image_tag 'popup/tit_h1_revise_first_work.gif', alt: '修正アリ', width: 235, height: 35
			else
				work_count.to_s + "稿修正作業中"
			end
		elsif current_action(status_id) == 22 #修正アリ 
				image_tag 'popup/tit_h1_dir_check.gif', alt: 'テストアップ', width: 235, height: 35
		elsif current_action(status_id) == 26 #内校戻し（画像アリ）
			image_tag 'popup/tit_h2_uchiko_img_file.gif', alt: '内校戻し（画像アリ）', width: 235, height: 35
		elsif current_action(status_id) == 9 #内校戻し
			image_tag 'popup/tit_h2_uchiko_work.gif', alt: '内校戻し', width: 235, height: 35
		elsif current_action(status_id) == 24 #確認出し中 
			image_tag 'popup/tit_h1_dir_request.gif', alt: '確認出し中', width: 235, height: 35
		elsif current_action(status_id) == 12 #リリース前チェック
			image_tag 'popup/tit_h1_release_before_check.gif', alt: 'リリース前チェック', width: 235, height: 35
		elsif current_action(status_id) == 14 #リリース待機
			image_tag 'popup/tit_h1_release_check.gif', alt: 'リリース待機', width: 235, height: 35
		elsif current_action(status_id) == 30 #リリース後チェック完了
			image_tag 'popup/tit_h1_dir_release_check.gif', alt: 'リリース待機', width: 326, height: 35
		elsif current_action(status_id) == 29 #Dirリリース前チェック
			image_tag 'popup/tit_h1_dir_release_before_check.gif', alt: 'Dirリリース前チェック', width: 326, height: 35
	  	end 

	end
	
	def image_h2_title(work_count)
		if  work_count == 1 
			image_tag 'popup/tit_h2_img_files_preparation.gif', alt: '画像等、準備中', width: 75, height: 18				
		elsif work_count == 2
			image_tag 'popup/tit_h2_img_files_preparation_2kou.gif', alt: '画像等、準備中(2稿依頼)', width: 113, height: 18				
		elsif work_count > 2
			"画像等準備(" + work_count.to_s + "稿依頼)"
		end
	end 

	def form_h2_title(work_count)
		if work_count == 1 	
			image_tag 'popup/tit_h2_first_work.gif', alt: '初稿作業', width: 75, height: 18				
		elsif work_count == 2
			image_tag 'popup/tit_h2_2nd_work.gif', alt: '2稿作業', width: 113, height: 18				
		elsif work_count > 2
			work_count.to_s + "稿作業"
		end
	end

	def reverse_h2_title(work_count)
		if work_count == 1 	
			image_tag 'popup/tit_h2_revise_first_work.gif', alt: '初稿修正作業中', width: 113, height: 18				
		elsif work_count > 1 
			work_count.to_s + "稿修正作業中"
		end	
	end 

	def dir_h2_title(work_count)
		if work_count == 1
			image_tag 'popup/tit_h2_dir_2nd_request.gif', alt: 'Dir作業中', width: 156, height: 18	
		elsif work_count == 2 
			image_tag 'popup/tit_h2_dir_3rd_request.gif', alt: 'Dir作業中', width: 156, height: 18	 
		elsif work_count > 2
			image_tag "popup/tit_h2_dir_#{work_count+1}th_request.gif", alt: 'Dir作業中', width: 156, height: 18	
		end		 
	end

	def history_dir_h2_title(work_count) 
		"Dir作業(" + ( work_count ).to_s + " 稿依頼)" 
	end

	def history_h2_title(work_count, previous_status=nil)
		if work_count == 1
			if previous_status == 21
				image_tag 'popup/tit_h2_revise_first_work.gif', alt: '初稿修正作業中', width: 113, height: 18
			else
				image_tag 'popup/tit_h2_first_work.gif', alt: '初稿作業中', width: 113, height: 18
			end				 
		elsif work_count == 2
			if previous_status == 21
				"2稿修正作業中"
			else
				image_tag 'popup/tit_h2_2nd_work.gif', alt: '2稿作業', width: 113, height: 18
			end	
		elsif work_count > 2
			if previous_status == 21
				work_count.to_s + "稿修正作業中"
			else
				work_count.to_s + "稿作業"
			end	
		end 
	end 
end
