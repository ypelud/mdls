class AddContextToTaggings < ActiveRecord::Migration
  def self.up
    #add_column :taggings, :context, :string, :limit => 128
    change_table :taggings do |t|
       t.references :tagger, :polymorphic => true

        # limit is created to prevent mysql error o index lenght for myisam table type.
        # http://bit.ly/vgW2Ql
        t.string :context, :limit => 128
    end
  end

  def self.down
    remove_column :taggings, :context
    remove_column :taggings, :tagger_id
  end
end

