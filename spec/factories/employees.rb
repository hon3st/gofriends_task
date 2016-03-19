FactoryGirl.define do
  factory :employee do
    sequence(:email) { |n| "employee#{n}@mail.com" }
    password { default_password }
    password_confirmation { password }
  end
end
