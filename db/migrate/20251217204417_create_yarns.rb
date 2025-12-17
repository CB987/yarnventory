class CreateYarns < ActiveRecord::Migration[8.1]
  def change
    create_table :yarns do |t|
      t.string :title

      t.timestamps
    end
  end
end
