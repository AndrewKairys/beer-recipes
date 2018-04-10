class RecipeFermentable < ApplicationRecord
  belongs_to :recipe
  belongs_to :fermentable

  # validates :amount, presence: true
end
