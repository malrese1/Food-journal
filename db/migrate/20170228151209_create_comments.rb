class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      # Good job specifying that the reference is a foreign key ++
      t.timestamps
    end
  end
end
