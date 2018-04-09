class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :style

  has_many :recipe_hops
  has_many :recipe_fermentables
  has_many :recipe_yeasts

  has_many :hops, through: :recipe_hops
  has_many :fermentables, through: :recipe_fermentables
  has_many :yeasts, through: :recipe_yeasts

  accepts_nested_attributes_for :fermentables, reject_if: lambda {|attributes| attributes['name'].blank?}
  accepts_nested_attributes_for :hops, reject_if: lambda {|attributes| attributes['name'].blank?}
  accepts_nested_attributes_for :yeasts, reject_if: lambda {|attributes| attributes['variety'].blank?}

  validates :name, presence: true

  def self.smash_beers
    self.all.find_all { |recipe| recipe.recipe_hops.count == 1 && recipe.recipe_fermentables.count == 1 }
  end

  def add_amounts(fermentable_amounts, hop_amounts)
    recipe_fermentables.each do |rf|
      rf.amount = fermentable_amounts[rf.fermentable_id - 1]
    end

    recipe_hops.each do |rh|
      rh.amount = hop_amounts[rh.hop_id - 1]
    end
  end

end
