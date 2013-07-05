require 'spec_helper'

describe SessionsController do
  describe "GET 'new'" do
    it "should returns http success" do
      get 'new'
      response.should be_success
    end

    it "should display login form with @user" do
      get 'new'
      response.should render_template("new")
      assigns.should have_key(:user)
    end
  end
  describe "POST 'create'" do
    before do 
      FactoryGirl.create(:user, :email => "test@test.com", :password => "correct", :password_confirmation => "correct")
    end
    it "should login with given email passwords" do
      get 'create', :user => {:email => "test@test.com", :password => "correct"}
      response.should redirect_to root_path
      assigns.should have_key(:user)
    end
    it "should not login with wrong email passwords and render new template" do
      get 'create', :user => { :email => "test@test.com", :password => "wrong" }
      response.should render_template("new")
      assigns.should have_key(:user)
    end
  end
  describe "DELETE 'create'" do
    it "should logout and redirect to root path" do
      delete 'destroy'
      response.should redirect_to root_path
    end
  end
end
