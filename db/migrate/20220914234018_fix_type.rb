class FixType < ActiveRecord::Migration[7.0]
  def change
    rename_column :roles, :type, :type_role
  end
end
