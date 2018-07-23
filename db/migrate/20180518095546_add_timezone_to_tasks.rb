class AddTimezoneToFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :files, :timezone, :string, default: 'UTC'
  end
end
