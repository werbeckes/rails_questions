class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :password_digest
      t.string    :email
      t.string    :cell
      t.datetime  :send_time
      t.boolean   :monday
      t.boolean   :tuesday
      t.boolean   :wednesday
      t.boolean   :thursday
      t.boolean   :friday
      t.boolean   :saturday
      t.boolean   :sunday

      t.timestamps
    end
  end
end
