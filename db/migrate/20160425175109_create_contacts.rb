class CreateContacts < ActiveRecord::Migration
  def change
    create_table(:contacts,{ id: false }) do |t|
      t.string :name
      t.string :number
      t.string :position
      t.string :field_company
      t.string :email
      t.integer :id
      t.integer :primary,null: false
      t.timestamps 
    end
  end
end
