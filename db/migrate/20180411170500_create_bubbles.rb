class CreateBubbles < ActiveRecord::Migration[5.2]
  def change
    create_table :bubbles do |t|

      t.timestamps
    end
  end
end
