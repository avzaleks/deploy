# This migration comes from refinery_deployments (originally 1)
class CreateDeploymentsDeployments < ActiveRecord::Migration

  def up
    create_table :refinery_deployments do |t|
      t.string :name_of_host
      t.string :ssh_port
      t.string :name_of_user
      t.string :user_password
      t.string :name_of_application
      t.string :path_for_deploy
      t.string :unicorn_or_puma
      t.string :capistrano_or_mina
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-deployments"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/deployments/deployments"})
    end

    drop_table :refinery_deployments

  end

end
