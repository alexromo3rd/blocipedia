class RanamePrivateToPrivateWiki < ActiveRecord::Migration
  def change
    rename_column :wikis, :private, :private_wiki
  end
end
