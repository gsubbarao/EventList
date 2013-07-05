require 'spec_helper'

describe User do
  describe "User creation" do
    context "Valdation check" do
      it "Should fail to save if email not present" do
        user = User.new(:name => 'aaa', :gender => User::GENDER[:MALE], :password => 'aaaa', :password_confirmation => 'aaaa')
        user.save.should == false
        user.errors.full_messages.should == ["Email can't be blank"]
      end
      it "Should fail to save if name not present" do
        user = User.new(:email => 'aaa@aaa.com', :gender => User::GENDER[:MALE], :password => 'aaaa', :password_confirmation => 'aaaa')
        user.save.should == false
        user.errors.full_messages.should == ["Name can't be blank"]
      end
      it "Should fail to save if password is blank" do
        user = User.new(:name => 'aaa', :email => 'aaa@aaa.com', :gender => User::GENDER[:MALE], :password => '', :password_confirmation => '')
        user.save.should == false
        user.errors.full_messages.include?("Password can't be blank")
      end
      it "Should fail to save if password and password_confirmation not match" do
        user = User.new(:name => 'aaa', :email => 'aaa@aaa.com', :gender => User::GENDER[:MALE], :password => 'aaaa', :password_confirmation => 'bbbb')
        user.save.should == false
        user.errors.full_messages.should == ["Password confirmation doesn't match Password"]
      end
    end
    context "Association check" do
      before(:each) do
        @user1 = FactoryGirl.create(:user)
        @user2 = FactoryGirl.create(:user)
        @event1 = FactoryGirl.create(:event, :owner_id => @user1.id)
        @event2 = FactoryGirl.create(:event, :owner_id => @user1.id)
        @event3 = FactoryGirl.create(:event, :owner_id => @user1.id)
      end
      it "@user1 should have three own_events" do
        @user1.own_events.should == [@event1, @event2, @event3]
      end
      it "@user1 should have one events" do
        @user1.events << @event1
        @user1.reload
        @user1.events.should == [@event1]
      end
      it "@user2 should have three events" do
        @user2.events << @event1
        @user2.events << @event2
        @user2.events << @event3
        @user2.reload
        @user2.events.should == [@event1, @event2, @event3]
      end
    end
  end
end

