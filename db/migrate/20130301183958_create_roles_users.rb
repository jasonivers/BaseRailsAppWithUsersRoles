class CreateRolesUsers < ActiveRecord::Migration
  def up
	create_table :roles_users, :id => false do |t|
		t.references :role, :user
	end
	if not table_exists? :environments_servers
		create_table :environments_servers, :id => false do |t|
			t.references :environment, :server
		end
	end
  end

  def down
	drop_table :roles_users
	drop_table(:environments_servers) if table_exists? :environments_servers
  end
end
