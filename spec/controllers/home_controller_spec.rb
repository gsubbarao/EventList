require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should returns http success" do
      get 'index'
      response.should be_success
    end

    it "should render index and include list of events" do
      event = FactoryGirl.create(:event, title: "Testing title")
      get 'index'
      response.should render_template("index")
      assigns.should have_key(:events)
      assigns(:events).should == [event]
    end
  end

end
