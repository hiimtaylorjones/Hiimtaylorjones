FactoryGirl.define do
  factory :admin do |f|
    p = Faker::Internet.password
    f.email                 { Faker::Internet.email }
    f.password              { p }
    f.password_confirmation { p }
  end
end
