require "erb"

module Refinery
  module Deployments
    class Deployment < Refinery::Core::BaseModel



      self.table_name = 'refinery_deployments'

      before_save :create_setups

      validates :name_of_host, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    protected

      def create_setups
        setup=self
        template_dir_for_deployer = Rails.root.to_s + "/deploy_templates/#{setup.capistrano_or_mina}"
        template_for_deploy_rb = File.read( template_dir_for_deployer + '/deploy.rb.erb' )
        result = ERB.new( template_for_deploy_rb ).result( binding )
        temp_dir_for_project = Rails.root.to_s + "/result/#{setup.name_of_application}/"
        Dir.mkdir( temp_dir_for_project )
        repository="git@github.com:avzaleks/MyFirstApp.git"
        process = system "cd #{temp_dir_for_project} && git clone #{repository} ."
        puts process

        get_ruby_version_and_gemset_name (temp_dir_for_project)


        f = File.new(temp_dir_for_project + 'config/deploy.rb', 'w')
        f.write(result )
        f.close

        #system "cd #{zzz} && git add --all && git commit -m 'bla-bla' && git push origin master"

      end

      def get_ruby_version_and_gemset_name (directory)

      end




    end
  end
end
