class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :new_email
      t.string :password_digest
      t.boolean :is_certificated

      t.timestamps
    end
  end
end
