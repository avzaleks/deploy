module Refinery
  module Deployments
    class DeploymentsController < ::ApplicationController

      before_action :find_all_deployments
      before_action :find_page


      def new
        @deployment=Deployment.new
      end


      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @deployment in the line below:
        present(@page)
      end

      def show
        @deployment = Deployment.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @deployment in the line below:
        present(@page)
      end

   def create
        @deployment=Refinery::Deployments::Deployment.new(deployment_params)
     @deployment.save!

        redirect_to :back
   end



    protected
      def deployment_params
        params.require(:deployment).permit(:gemset, :repo_url, :title, :name_of_host, :ssh_port, :name_of_user, :user_password, :name_of_application, :path_for_deploy, :unicorn_or_puma, :capistrano_or_mina)
      end

      def find_all_deployments
        @deployments = Deployment.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/deployments").first
      end

    end
  end
end
