class AddUserRefToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :blogs, :user, null: true, foreign_key: true
  end
end
