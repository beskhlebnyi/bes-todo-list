class AddImportantToFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :files, :important, :boolean
  end
end
