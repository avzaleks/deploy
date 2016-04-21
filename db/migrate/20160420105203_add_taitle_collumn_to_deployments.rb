class AddTaitleCollumnToDeployments < ActiveRecord::Migration
  def change
    add_column :refinery_deployments, :title, :string
  end
end
