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

  def add_fermentable_amounts(fermentable_amounts)
    array = fermentable_amounts.first.keep_if { |k, v| v != "" }

    array.each do |k,v|
      RecipeFermentable.create(recipe_id: self.id, fermentable_id: k.to_i, amount: v.to_f)
    end
  end

  def add_hop_amounts(hop_amounts)
    amounts = hop_amounts.first.keep_if { |k, v| v != "" }

    amounts.each do |k,v|
      rh = RecipeHop.create(recipe_id: self.id, hop_id: k.to_i, amount: v.to_f)
    end
  end

  def add_addition_time(addition_time)
    array = addition_time.first.keep_if { |k, v| v != "" }

    array.each do |k,v|
      rh = recipe_hops.find_by(hop_id: k.to_i)
      rh.addition_time = v.to_f
      rh.save
    end
  end

end
