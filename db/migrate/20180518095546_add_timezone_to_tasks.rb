class AddTimezoneToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :timezone, :string, default: 'UTC'
  end
end
