# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    asset_file_name "MyString"
    asset_content_type "MyString"
    asset_file_size 1
    asset_uploaded_at "2012-08-05 11:52:15"
    post_id 1
  end
end
