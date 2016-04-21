module Refinery
  module Deployments
    module Admin
      class DeploymentsController < ::Refinery::AdminController

        crudify :'refinery/deployments/deployment',
                :title_attribute => 'name_of_host'

        private

        # Only allow a trusted parameter "white list" through.
        def deployment_params
          params.require(:deployment).permit(:gemset, :repo_url, :title, :name_of_host, :ssh_port, :name_of_user, :user_password, :name_of_application, :path_for_deploy, :unicorn_or_puma, :capistrano_or_mina)
        end
      end
    end
  end
end
