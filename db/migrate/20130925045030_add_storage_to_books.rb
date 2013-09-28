class AddStorageToBooks < ActiveRecord::Migration
  def change
    add_column :books, :storage, :string
  end
end
