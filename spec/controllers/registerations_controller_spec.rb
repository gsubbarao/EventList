require 'spec_helper'

describe RegisterationsController do
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

    it "should create user with given email passwords" do
      get 'create', :user => { :name => "AAAAA", :email => "test@test.com", :password => "correct", :password_confirmation => "correct"}
      response.should redirect_to root_path
      assigns.should have_key(:user)
    end
    it "should not create user with wrong email passwords and render new template" do
      get 'create', :user => { :name => "AAAAA", :email => "test", :password => "correct", :password_confirmation => "wrong" }
      response.should render_template("new")
      assigns.should have_key(:user)
    end
  end
end
