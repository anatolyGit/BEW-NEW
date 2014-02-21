# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'bcrypt'
my_password = BCrypt::Password.create("admin")
User.create(:login => "admin",  :password_digest => my_password, :authority => 1 )

worksbh = BCrypt::Password.create("worksbh")
User.create(:login => "dirbhw", :password_digest => worksbh, :authority => 1 )
User.create(:login => "opebhw", :password_digest => worksbh, :authority => 2 )

# status code
Status.create(:name => "着手可")
Status.create(:name => "画像等・準備中")
Status.create(:name => "中断")
Status.create(:name => "中断、再作業")
Status.create(:name => "Wチェック待ち")
Status.create(:name => "修正中")
Status.create(:name => "Dir作業中")
Status.create(:name => "Dirチェック中")
Status.create(:name => "内校戻し")
Status.create(:name => "内校戻し中断")
Status.create(:name => "Dir作業")
Status.create(:name => "リリース前チェック")
Status.create(:name => "Dirリリース前チェック")
Status.create(:name => "リリース待機")
Status.create(:name => "リリース")
Status.create(:name => "着手" )
Status.create(:name => "画像" )
Status.create(:name => "作業ストップ" )
Status.create(:name => "中断" )
Status.create(:name => "チェックOK" )
Status.create(:name => "修正アリ" )
Status.create(:name => "テストアップ" )
Status.create(:name => "初稿確認出し中" )
Status.create(:name => "確認出し中" )
Status.create(:name => "初稿内校戻し" )
Status.create(:name => "内校戻し（画像アリ）" )
Status.create(:name => "内校戻しWチェック待ち" )
Status.create(:name => "Fix、リリース前チェック" )
Status.create(:name => "リリース前チェック完了" )
Status.create(:name => "リリース後チェック完了" )
Status.create(:name => "案件完了" )
