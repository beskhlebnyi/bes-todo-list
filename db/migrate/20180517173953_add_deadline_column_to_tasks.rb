class AddDeadlineColumnToFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :files, :deadline, :datetime, null: true
  end
end
