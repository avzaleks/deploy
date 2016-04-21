require 'spec_helper'

module Refinery
  module Deployments
    describe Deployment do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:deployment,
          :name_of_host => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name_of_host) { should == "Refinery CMS" }
      end
    end
  end
end
