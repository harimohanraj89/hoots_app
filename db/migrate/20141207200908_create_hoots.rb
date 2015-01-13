class CreateHoots < ActiveRecord::Migration
  def change
    create_table :hoots do |t|
    	t.string :content, limit: 140, null: false
    	t.string :author, null: false

    	t.timestamps
    end
  end
end