class AdoptionAgreement < ActiveRecord::Base
  has_one :pet, dependent: :destroy
end
