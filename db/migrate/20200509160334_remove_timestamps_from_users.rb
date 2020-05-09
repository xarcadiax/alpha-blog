class RemoveTimestampsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :timestamps, :string
  end
end
