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

  #CLASS METHODS
  def self.smash_beers
    self.all.find_all { |recipe| recipe.recipe_hops.count == 1 && recipe.recipe_fermentables.count == 1 }
  end

  #ADD NEW STYLE
  def add_new_style(style_name)
    if style_name != ""
      self.build_style(name: style_name)
    end
  end

  #ADD ATTRIBUTES TO ALREADY CREATED INGREDIENTS
  def add_recipe_fermentables(fermentable_amounts, fermentable_ids)
    amounts = fermentable_amounts.first.keep_if { |k, v| fermentable_ids.include?(k) }

    amounts.each do |k,v|
      RecipeFermentable.create(recipe_id: self.id, fermentable_id: k.to_i, amount: v.to_f)
    end
  end

  def add_recipe_hops(recipe_hop_attributes, hop_ids)
    hop_ids.delete("")
    
    if hop_ids != []
      recipe_hop_attributes.each do |k, v|
        rh = RecipeHop.create(recipe_id: self.id, hop_id: k.to_i, amount: v[:amount].to_f, addition_time: v[:addition_time].to_f)
      end
    end
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

  def add_recipe_hop_amount(rh_amount, rh_addition_time)
    if rh_amount != ""
      hop_id = Hop.all[-1].id
      rh = recipe_hops.find_by(hop_id: hop_id)
      rh.amount = rh_amount.to_f
      rh.addition_time = rh_addition_time.to_f
      rh.save
    end
  end

  #UPDATE METHODS
  #***refactor these?***
  def update_fermentables(fermentable_amounts, fermentable_ids, new_fermentable_amount)
    if new_fermentable_amount != ""
      new_recipe_fermentable = recipe_fermentables.last
    end

    amounts = fermentable_amounts.first.keep_if { |k, v| fermentable_ids.include?(k) }

    amounts.each do |k, v|
      recipe_fermentable = recipe_fermentables.where(fermentable_id: k.to_i).first_or_create
      recipe_fermentable.amount = v.to_f
      recipe_fermentable.save
    end
    delete_fermentables(fermentable_ids, new_recipe_fermentable)

  end

  def delete_fermentables(fermentable_ids, new_recipe_fermentable)
    recipe_fermentable_ids = recipe_fermentables.collect { |rf| rf.fermentable_id }

    fermentable_id_integers = fermentable_ids.collect { |id| id.to_i }
    fermentable_id_integers.shift

    if new_recipe_fermentable.nil?
      to_delete = recipe_fermentable_ids - fermentable_id_integers
    else
      rfi = recipe_fermentable_ids.reject { |n| n == new_recipe_fermentable.fermentable_id }
      to_delete = rfi - fermentable_id_integers
    end

    to_delete.each do |id|
      rf = recipe_fermentables.find_by(fermentable_id: id)
      rf.destroy
    end

  end

  def update_hops(recipe_hop_attributes, hop_ids, new_hop_amount)
    if new_hop_amount != ""
      new_recipe_hop = recipe_hops.last
    end

    if recipe_hop_attributes != nil
      recipe_hop_attributes.each do |k, v|
        recipe_hop = recipe_hops.where(hop_id: k.to_i).first_or_create
        recipe_hop.amount = v[:amount].to_f
        recipe_hop.addition_time = v[:addition_time].to_f
        recipe_hop.save
      end
    end

    delete_hops(hop_ids, new_recipe_hop)
  end

  # Once duplicate hops can be entered, Make it so it filters by recipe_hop.id instead of hop_id
  def delete_hops(hop_ids, new_recipe_hop)
    if new_recipe_hop != nil
      hop_ids.push(new_recipe_hop.hop_id.to_s)
    end

    recipe_hops.each do |recipe_hop|
      if !hop_ids.include?(recipe_hop.hop_id.to_s)
        recipe_hop.destroy
      end
    end
  end

end
