FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| "Blue#{n}" }
  end
end
