class AddPolicyLinksToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :policies_one_link, :string
    add_column :clubs, :policies_one_text, :string
    add_column :clubs, :policies_two_link, :string
    add_column :clubs, :policies_two_text, :string
    add_column :clubs, :policies_three_link, :string
    add_column :clubs, :policies_three_text, :string
    add_column :clubs, :policies_four_link, :string
    add_column :clubs, :policies_four_text, :string
    add_column :clubs, :policies_five_link, :string
    add_column :clubs, :policies_five_text, :string
    add_column :clubs, :policies_six_link, :string
    add_column :clubs, :policies_six_text, :string
  end
end
