module Refinery
  module Deployments
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Deployments

      engine_name :refinery_deployments

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "deployments"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.deployments_admin_deployments_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Deployments)
      end
    end
  end
end
