class AddCopiesAvailableToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :copies_available, :integer,default:0
  end
end
