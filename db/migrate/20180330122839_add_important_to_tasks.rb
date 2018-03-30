class AddImportantToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :important, :boolean
  end
end
