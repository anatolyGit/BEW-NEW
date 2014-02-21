# encoding: utf-8
require 'spec_helper'

feature 'User can create new project', js: true do
  given(:user) { FactoryGirl.create(:user) }

  background do
    Status.create(name: '着手可')
    Status.create(name: '画像等・準備中')

    visit login_path
    within('form') do
      fill_in :login, with: user.login
      fill_in :password, with: user.password
      click_button 'ログイン'
    end

    visit new_project_path
  end

  scenario 'user should see the form' do
    within '#my-form' do
      expect(page).to have_select '案件区分:'
      expect(page).to have_field '案件番号:'
      expect(page).to have_field 'リリース日:'
      expect(page).to have_field '案件名:'
      expect(page).to have_field 'テストアップ:'
      expect(page).to have_field '対象URL：'
      expect(page).to have_field '作業内容：'
    end
  end

  context 'clicking "一時保存" button' do
    background do
      within '#my-form' do
        click_button '一時保存'
      end
    end

    scenario 'go back to the project list and see the saved project' do
      expect(current_path).to eq(projects_path)
    end
  end

  context 'clicking "確認" button' do
    background do
      within '#my-form' do
        select 'AMC運用'
        fill_in :project_number, with: 'AMC-111-222'
        fill_in :project_release_date, with: '13-10-31-21'
        fill_in :project_name, with: 'This is a sample project'
        fill_in :project_submit_date, with: '13-11-30-09'
        fill_in :project_testup, with: '13-12-01-23'
        fill_in :project_estimation, with: '1.5'
        fill_in :project_urls, with: 'http://www.example.com/'
        fill_in :project_content, with: 'this is your work'
        find('#project_progress_available').trigger('click')

        click_button '確認'
      end
    end

    scenario 'move to "確認" page and shows given values' do
      within '#my-form' do
        expect(page).to have_content 'AMC運用'
        expect(page).to have_content 'AMC-111-222'
        expect(page).to have_content '13-10-31-21'
        expect(page).to have_content 'This is a sample project'
        expect(page).to have_content '13-11-30-09'
        expect(page).to have_content '13-12-01-23'
        expect(page).to have_content '1.5 h'
        expect(page).to have_content 'http://www.example.com/'
        expect(page).to have_content 'this is your work'
      end
    end

    context 'clicking "作成" ' do
      background do 
        click_button '作成'
      end

      scenario 'saves new project and redirect to project list' do
        expect(current_path).to eq(projects_path) 

        expect(page).to have_content 'This is a sample project'
      end
    end

    context 'clicking "再編集"' do
      background do
        click_button '再編集'
      end

      scenario 'all fileds have been filled with given values' do
        expect(current_path).to eq(new_project_path)

        expect(page).to have_field(:project_number, with: 'AMC-111-222')
        expect(page).to have_field(:project_release_date, with: '13-10-31-21')
        expect(page).to have_field(:project_name, with: 'This is a sample project')
        expect(page).to have_field(:project_submit_date, with: '13-11-30-09')
        expect(page).to have_field(:project_testup, with: '13-12-01-23')
        expect(page).to have_field(:project_estimation, with: '1.5')
        expect(page).to have_field(:project_urls, with: 'http://www.example.com/')
        expect(page).to have_field(:project_content, with: 'this is your work')
      end
    end
  end
end
