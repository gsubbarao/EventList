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
        describe "GET 'show'" do
      event = FactoryGirl.create(:event)
      it "should show the event details and attending users" do
        get 'show', :id => event.id
        response.should render_template("show")
        assigns.should have_key(:event)
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
    describe "GET 'show'" do
      event = FactoryGirl.create(:event)
      it "should show the event details and attending users" do
        get 'show', :id => event.id
        response.should render_template("show")
        assigns.should have_key(:event)
      end
    end
    describe "get 'attend_or_not'" do
      before(:each) do
        request.env["HTTP_REFERER"] = "show"
        @user = FactoryGirl.create(:user) 
        session[:user_id] = @user.id
        @event = FactoryGirl.create(:event)
      end
      it "should attend this event" do
        get 'attend_or_not', :id => @event.id
        @user.reload
        @user.events.should == [@event]
        response.should redirect_to "show"
      end
      it "should unattend this event" do
        @user.events << @event
        get 'attend_or_not', :id => @event.id
        @user.reload
        @user.events.should_not == [@event]
        response.should redirect_to "show"
      end
    end
  end

end
