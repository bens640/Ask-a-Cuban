class Addupdatedcommentcount < ActiveRecord::Migration
  def change
    add_column :items, :updated_comment_count, :integer
  end
end
