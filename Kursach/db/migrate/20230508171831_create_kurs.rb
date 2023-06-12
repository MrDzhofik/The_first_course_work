class CreateKurs < ActiveRecord::Migration[7.0]
  def change
    create_table :kurs do |t|

      t.timestamps
    end
  end
end
