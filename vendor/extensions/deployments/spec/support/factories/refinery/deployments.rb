
FactoryGirl.define do
  factory :deployment, :class => Refinery::Deployments::Deployment do
    sequence(:name_of_host) { |n| "refinery#{n}" }
  end
end

