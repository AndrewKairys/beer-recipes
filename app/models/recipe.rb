class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :style

  has_many :recipe_hops, :dependent => :destroy
  has_many :recipe_fermentables, :dependent => :destroy
  has_many :recipe_yeasts, :dependent => :destroy

  has_many :hops, through: :recipe_hops
  has_many :fermentables, through: :recipe_fermentables
  has_many :yeasts, through: :recipe_yeasts

  accepts_nested_attributes_for :fermentables, reject_if: lambda {|attributes| attributes['name'].blank?}
  accepts_nested_attributes_for :hops, reject_if: lambda {|attributes| attributes['name'].blank?}
  accepts_nested_attributes_for :yeasts, reject_if: lambda {|attributes| attributes['variety'].blank?}

  validates :name, presence: true
  validates_associated :recipe_yeasts

  #CLASS METHODS
  def self.smash_beers
    self.all.find_all { |recipe| recipe.recipe_hops.count == 1 && recipe.recipe_fermentables.count == 1 }
  end

  #ADD ATTRIBUTES TO NEWLY CREATED INGREDIENTS
  def add_recipe_fermentable_amount(rf_amount)
    if rf_amount != ""
      fermentable_id = Fermentable.all[-1].id
      rf = recipe_fermentables.find_by(fermentable_id: fermentable_id)
      rf.amount = rf_amount.to_f
      rf.save
    end
  end

  def add_recipe_hop_amount(rh_amount)
    if rh_amount != ""
      hop_id = Hop.all[-1].id
      rh = recipe_hops.find_by(hop_id: hop_id)
      rh.amount = rh_amount.to_f
      rh.save
    end
  end

  def add_recipe_hop_addition_time(rh_addition_time)
    if rh_addition_time != ""
      hop_id = Hop.all[-1].id
      rh = recipe_hops.find_by(hop_id: hop_id)
      rh.addition_time = rh_addition_time.to_f
      rh.save
    end
  end

  #ADD ATTRIBUTES TO ALREADY CREATED INGREDIENTS
  def add_recipe_fermentables(fermentable_amounts, fermentable_ids)
    amounts = fermentable_amounts.first.keep_if { |k, v| fermentable_ids.include?(k) }

    amounts.each do |k,v|
      RecipeFermentable.create(recipe_id: self.id, fermentable_id: k.to_i, amount: v.to_f)
    end
  end

  def add_recipe_hops(hop_amounts, hop_ids)
    amounts = hop_amounts.first.keep_if { |k, v| hop_ids.include?(k) }

    amounts.each do |k,v|
      rh = RecipeHop.create(recipe_id: self.id, hop_id: k.to_i, amount: v.to_f)
    end
  end

  def add_addition_time(addition_time, hop_ids)
    times = addition_time.first.keep_if { |k, v| hop_ids.include?(k) }

    times.each do |k,v|
      rh = recipe_hops.find_by(hop_id: k.to_i)
      rh.addition_time = v.to_f
      rh.save
    end
  end

  #UPDATE METHODS
  def update_fermentable_amounts(fermentable_amounts)
    fermentable_amounts.collect do |ferm|

    end
    amounts = fermentable_amounts.first.keep_if { |k, v| v != "" }

    amounts.each do |k,v|
      rf = recipe_fermentables.find_by(id: k.to_i)
      rf.amount = v.to_f
      rf.save
    end
  end

  #***refactor this***
  def update_hops(hop_amounts, addition_time, hop_ids, new_hop_amount)
    if new_hop_amount != ""
      new_recipe_hop = recipe_hops.last
    end

    amounts = hop_amounts.first.keep_if { |k, v| hop_ids.include?(k) }
    times = addition_time.first.keep_if { |k, v| hop_ids.include?(k) }

    amounts.each do |k, v|
      recipe_hop = recipe_hops.where(hop_id: k.to_i).first_or_create
      recipe_hop.amount = v.to_f
      recipe_hop.save
    end

    times.each do |k, v|
      recipe_hop = recipe_hops.where(hop_id: k.to_i).first_or_create
      recipe_hop.addition_time = v.to_f
      recipe_hop.save
    end

    delete_hops(hop_ids, new_recipe_hop)
  end

  def delete_hops(hop_ids, new_recipe_hop)
    recipe_hop_ids = recipe_hops.collect { |rh| rh.hop_id }

    hop_id_integers = hop_ids.collect { |id| id.to_i }
    hop_id_integers.shift

    if new_recipe_hop.nil?
      to_delete = recipe_hop_ids - hop_id_integers
    else
      rhi = recipe_hop_ids.reject { |n| n == new_recipe_hop.hop_id }
      to_delete = rhi - hop_id_integers
    end

    to_delete.each do |id|
      rh = recipe_hops.find_by(hop_id: id)
      rh.destroy
    end
  end

end
