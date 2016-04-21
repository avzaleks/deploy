# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Deployments" do
    describe "Admin" do
      describe "deployments", type: :feature do
        refinery_login

        describe "deployments list" do
          before do
            FactoryGirl.create(:deployment, :name_of_host => "UniqueTitleOne")
            FactoryGirl.create(:deployment, :name_of_host => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.deployments_admin_deployments_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.deployments_admin_deployments_path

            click_link "Add New Deployment"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name Of Host", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Deployments::Deployment, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Deployments::Deployment, :count)

              expect(page).to have_content("Name Of Host can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:deployment, :name_of_host => "UniqueTitle") }

            it "should fail" do
              visit refinery.deployments_admin_deployments_path

              click_link "Add New Deployment"

              fill_in "Name Of Host", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Deployments::Deployment, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:deployment, :name_of_host => "A name_of_host") }

          it "should succeed" do
            visit refinery.deployments_admin_deployments_path

            within ".actions" do
              click_link "Edit this deployment"
            end

            fill_in "Name Of Host", :with => "A different name_of_host"
            click_button "Save"

            expect(page).to have_content("'A different name_of_host' was successfully updated.")
            expect(page).not_to have_content("A name_of_host")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:deployment, :name_of_host => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.deployments_admin_deployments_path

            click_link "Remove this deployment forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Deployments::Deployment.count).to eq(0)
          end
        end

      end
    end
  end
end
