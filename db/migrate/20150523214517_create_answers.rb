class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text       :value
      t.datetime   :answer_for
      t.references :question, index: true, foreign_key: true

      t.timestamps
    end
  end
end
