class CreateAdoptionAgreements < ActiveRecord::Migration
  def change
    create_table :adoption_agreements do |t|

      t.timestamps
    end
  end
end
