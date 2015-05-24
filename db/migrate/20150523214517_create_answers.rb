class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string     :value
      t.references :question, index: true, foreign_key: true
      t.timedate   :answer_for

      t.timestamps
    end
  end
end
