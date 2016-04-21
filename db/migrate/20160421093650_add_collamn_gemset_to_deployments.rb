class AddCollamnGemsetToDeployments < ActiveRecord::Migration
  def change
    add_column :refinery_deployments, :gemset, :string
  end
end
