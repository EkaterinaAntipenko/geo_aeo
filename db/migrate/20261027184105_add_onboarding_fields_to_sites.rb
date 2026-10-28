class AddOnboardingFieldsToSites < ActiveRecord::Migration[8.1]
  def change
    add_column :sites, :brand_name, :string
    add_column :sites, :pages_plan, :string
  end
end
