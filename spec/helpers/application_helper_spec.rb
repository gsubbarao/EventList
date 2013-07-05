require 'spec_helper'

describe ApplicationHelper do
  describe "Can attend event" do
    it "should return true if user login and scheduled date is greter than current date" do
      view.stubs(:user_siginin?).returns(true)
      helper.can_attend?( (DateTime.now + 1.day) ).should == true
    end
    it "should return false if user not login" do
      view.stubs(:user_siginin?).returns(false)
      helper.can_attend?( (DateTime.now + 1.day) ).should == false
    end
    it "should return true if user scheduled date is less than current date" do
      view.stubs(:user_siginin?).returns(true)
      helper.can_attend?( (DateTime.now - 1.day) ).should == false
    end
    it "should return true if user not login and scheduled date is less than current date" do
      view.stubs(:user_siginin?).returns(false)
      helper.can_attend?( (DateTime.now - 1.day) ).should == false
    end
  end
  describe "Event attend status" do
    let(:user) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event) }
    it "should return Attend if he is not attend that event" do
      view.stubs(:current_user).returns(user)
      helper.attentd_status(event).should == "Attend"
    end
    it "should return Unattend he is attend that event" do
      user.events << event
      view.stubs(:current_user).returns(user)
      helper.attentd_status(event).should == "Unattend"
    end
  end
end
