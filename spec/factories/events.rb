# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner_id 1
    title "MyString"
    description "MyText"
    scheduled "2013-07-04 18:11:35"
  end
end
