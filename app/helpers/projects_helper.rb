module ProjectsHelper 
	def status_name(status_list, id, work_count = 0, prev_id = 0 )  
		if ( id == 1 || id == 16 || id == 2) && work_count > 1 
			work_count.to_s + "稿依頼"
		elsif id == 17 && work_count > 1 
			work_count.to_s + "稿依頼（画像アリ）"
		elsif id == 22 && work_count > 1
			work_count.to_s + "稿テストアップ"
		elsif id == 23 && work_count > 1
			work_count.to_s + "稿確認出し中"
		elsif id == 5 && work_count > 1
			work_count.to_s + "稿依頼（Wチェック待ち）"
		elsif id == 21 && work_count > 1
			work_count.to_s + "稿依頼（修正アリ）"
		elsif id == 18
			if prev_id == 9
				if work_count == 1
				"初稿内校戻し"
				elsif work_count > 1
					work_count.to_s + "稿内校戻し"
				end
			else
				status_list[1] 
			end  
		elsif id == 29		# リリース前チェック完了
			status_list[28] # Fix、リリース前チェック  	
		elsif id == 9  
			if work_count == 1
				"初稿内校戻し"
			elsif work_count > 1
				work_count.to_s + "稿内校戻し"
			end
		elsif id == 10
			if work_count == 0
				"初稿内校戻し"
			elsif work_count > 1
				work_count.to_s + "稿内校戻し"
			end
		elsif id == 27
			status_list[5]
		elsif id == 4
			status_list[21]
		elsif id == 16
			status_list[1]  		
		else
			status_list[id]  		
		end
	end

	def action_name(status_list, id, work_count = 0)  
		if ( id == 1 || id == 16 || id == 2) && work_count > 1 
			work_count.to_s + "稿依頼"
		elsif id == 17 && work_count > 1 
			work_count.to_s + "稿依頼（画像アリ）"  
		else
			status_list[id]  		
		end
	end	

	def working_status_name(status_list, id)
		status_list[id].to_s
	end

	def time_format(tf)
		unless tf.blank?
			tf.strftime("%y-%m-%d-%I")
		else
			tf
		end
	end
 
	def action_permission(status_id)
		# status_id = current_action(id)
		if super_user
			true
		elsif ( status_id == 1 || 
				status_id == 2 || #  画像アリ
				status_id == 3 || # 中断
				status_id == 9 || # 内校戻し
				status_id == 12 || # リリース前チェック
				status_id == 16 || # 着手	
				status_id == 5 ||  # Wチェック待ち	
				status_id == 19 || # 中断 
				status_id == 21 || # 修正アリ
				status_id == 14 || # リリース待機
				status_id == 17 || # 画像
				status_id == 25 || # 画像
				status_id == 26   # 内校戻し（画像アリ）
			) && open_user
			true
		else
			false
		end
	end

  def get_file_name(path)  	 
    r_index = path.rindex("/")
    file_name = path[r_index + 1, path.length]
    file_name
  end

  def get_action_css(status_id)
  	style = current_action( status_id )
		"action status" + style.to_s
	end

	def current_action( status_id )
		if status_id == 16
			16 	#着手
		elsif status_id == 1
			16	#着手
		elsif status_id == 2
			17 	#画像
		elsif status_id == 4
			3 	#画像
		elsif status_id == 5			
			5 	#Wチェック待ち
		elsif status_id == 18 #作業ストップ
			19 	#中断
		elsif status_id == 22 #テストアップ
			22 	#テストアップ
		elsif status_id == 21 || status_id == 4 #修正アリ
			21 	#修正アリ
		elsif status_id == 23 #初稿確認出し中
			24 	#確認出し中
		elsif status_id == 25 #初稿内校戻し
			26 	#内校戻し（画像アリ）
		elsif status_id == 9 	# 内校戻し
			9	# 内校戻し
		elsif status_id == 10 	# 内校戻し中断
			3	# 初稿内校戻し
		elsif status_id == 27 	# 内校戻しWチェック待ち
			5	# 内校戻しWチェック待ち
		elsif status_id == 11 # Dir作業中
			11
		elsif status_id == 28  # Fix、リリース前チェック
			12 					# リリース前チェック完了
		elsif status_id == 29	# Dirリリース前チェック
			29					# Dirリリース前チェック	
		elsif status_id == 14	# リリース待機
			14					# リリース待機
		elsif status_id == 30	# リリース後チェック完了
			30					# リリース後チェック完了
		elsif status_id == 31	# 案件完了
			31					# 案件完了
		end 
	end
end
