require 'spec_helper'

describe ProjectsController do
  describe 'GET /new' do
    specify 'assign an initialized Project object' do
      get :new

      expect(assigns[:project]).to be_a(Project)
      expect(assigns[:project]).to be_new_record
    end
  end
end
