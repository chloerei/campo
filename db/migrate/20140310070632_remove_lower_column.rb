class RemoveLowerColumn < ActiveRecord::Migration
  def change
    remove_column :users, :username_lower
    remove_column :users, :email_lower
    remove_index :users, :username
    remove_index :users, :email
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_username ON users USING btree (lower(username))"
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_email ON users USING btree (lower(email))"

    remove_column :categories, :slug_lower
    remove_index :categories, :slug
    execute "CREATE UNIQUE INDEX index_categories_on_lowercase_slug ON categories USING btree (lower(slug))"
  end
end
