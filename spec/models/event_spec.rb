require 'spec_helper'

describe Event do
  describe "Event creation" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    context "Valdation check" do
      it "Should fail to save if title not present" do
        event = Event.new(description: 'aaa', scheduled: DateTime.now, owner_id: @user.id)
        event.save.should == false
        event.errors.full_messages.should == ["Title can't be blank"]
      end
      it "Should fail to save if scheduled not present" do
        event = Event.new(:description => 'aaa', :title => 'test', :owner_id => @user.id)
        event.save.should == false
        event.errors.full_messages.should == ["Scheduled can't be blank"]
      end
      it "Should fail to save if owner_id not present" do
        event = Event.new(:title => 'aaa', :scheduled => DateTime.now, :description => 'test')
        event.save.should == false
        event.errors.full_messages.should == ["Owner can't be blank"]
      end
    end
    context "Association check" do
      it "@user1 should have three own_events" do
        event = FactoryGirl.create(:event, :owner_id => @user.id)
        event.reload
        event.owner.should == @user
      end
      it "@user1 should have one events" do
        event = FactoryGirl.create(:event, :owner_id => @user.id)
        @user.events << event
        event.reload
        event.users.should == [@user]
      end
    end

  end
end
