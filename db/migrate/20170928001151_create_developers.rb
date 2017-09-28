class CreateDevelopers < ActiveRecord::Migration[5.1]
  def change
    create_table :developers do |t|

      t.timestamps
    end
  end
end
