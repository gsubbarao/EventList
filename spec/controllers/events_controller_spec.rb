require 'spec_helper'

describe EventsController do
  context "Without login" do
    describe "GET 'new'" do
      it "should returns http get 302 responce" do
        get 'new'
        response.status.should == 302
      end

      it "should redirect to root path" do
        get 'new'
        response.should redirect_to root_path
      end
    end
    describe "POST 'create'" do
      it "should fails create event with correct values and redirect to root path" do
        get 'create', :event => {:title => "Testing title", :description => "correct", :scheduled => "2013-07-04 18:11:35"}
        response.status.should == 302
        response.should redirect_to root_path
      end
      it "should fails to create with fail values and redirect to root path" do
        get 'create', :event => { :description => "correct", :scheduled => "2013-07-04 18:11:35"}
        response.status.should == 302
        response.should redirect_to root_path
      end
    end
  end
  context "With login" do
    before do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
    end
    describe "GET 'new'" do
      it "should returns http success" do
        get 'new'
        response.should be_success
      end

      it "should display login form with @user" do
        get 'new'
        response.should render_template("new")
        assigns.should have_key(:event)
      end
    end
    describe "POST 'create'" do
      it "should create event and redirect to event list page" do
        get 'create', :event => {:title => "Testing title", :description => "correct", :scheduled => "2013-07-04 18:11:35"}
        response.should redirect_to root_path
      end
      it "should fails to create event and render event form" do
        get 'create', :event => { :description => "correct", :scheduled => "2013-07-04 18:11:35"}
        response.should render_template("new")
      end
    end
  end

end
