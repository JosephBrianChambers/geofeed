class DropTodosAndItemsAndBubbles < ActiveRecord::Migration[5.2]
  def up
    drop_table :todos if table_exists?(:todos)
    drop_table :items if table_exists?(:items)
    drop_table :bubbles if table_exists?(:bubbles)
    drop_table :quotes if table_exists?(:quotes)
  end

  def down
  end

  private

  def table_exists?(table_name)
    ActiveRecord::Base.connection.table_exists? table_name.to_s
  end
end
