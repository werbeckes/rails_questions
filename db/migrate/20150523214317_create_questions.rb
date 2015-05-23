class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :answer_type
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
