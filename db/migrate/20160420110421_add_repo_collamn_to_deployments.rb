class AddRepoCollamnToDeployments < ActiveRecord::Migration
  def change
    add_column :refinery_deployments, :repo_url, :string
  end
end
