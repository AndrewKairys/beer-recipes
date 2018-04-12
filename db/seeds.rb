# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Fermentables
  fermentables = Fermentable.create([
    { name: 'American 2-Row', pound_per_gallon: 37, lovibond: 1.8, diastatic_power: 140},
    { name: 'American 6-Row', pound_per_gallon: 35, lovibond: 1.8, diastatic_power: 35},
    { name: 'Caramel/Crystal 20', pound_per_gallon: 35, lovibond: 20, diastatic_power: 0},
    { name: 'Caramel/Crystal 40', pound_per_gallon: 34, lovibond: 40, diastatic_power: 0},
    { name: 'Caramel/Crystal 60', pound_per_gallon: 34, lovibond: 60, diastatic_power: 0},
    { name: 'Caramel/Crystal 80', pound_per_gallon: 33, lovibond: 80, diastatic_power: 0},
    { name: 'Caramel/Crystal 90', pound_per_gallon: 33, lovibond: 90, diastatic_power: 0},
    { name: 'Caramel/Crystal 120', pound_per_gallon: 33, lovibond: 120, diastatic_power: 0},
    { name: 'Pilsner', pound_per_gallon: 37, lovibond: 1.8, diastatic_power: 110},
    { name: 'Vienna', pound_per_gallon: 35, lovibond: 4, diastatic_power: 50},
    { name: 'Maris Otter Pale', pound_per_gallon: 38, lovibond: 3.75, diastatic_power: 120},
    { name: 'Victory', pound_per_gallon: 34, lovibond: 28, diastatic_power: 0},
    { name: 'Unmalted Wheat', pound_per_gallon: 38, lovibond: 1.8, diastatic_power: 0},
    { name: 'Chocolate Malt', pound_per_gallon: 29, lovibond: 350, diastatic_power: 0},
    { name: 'British 2-Row', pound_per_gallon: 38, lovibond: 2.5, diastatic_power: 45}
    ])
#Hops
  hops = Hop.create([
    { name: 'Cascade', alpha_acids: 7},
    { name: 'Citra', alpha_acids: 13},
    { name: 'Centennial', alpha_acids: 9.5},
    { name: 'Amarillo', alpha_acids: 9},
    { name: 'Saaz', alpha_acids: 3.5},
    { name: 'Hallertau', alpha_acids: 5},
    { name: 'Magnum', alpha_acids: 14},
    { name: 'Chinook', alpha_acids: 13},
    { name: 'Mosaic', alpha_acids: 12},
    ])
#Yeasts
  yeasts = Yeast.create([
    { brand: 'Wyeast', variety: 'American Ale 1056' },
    { brand: 'Wyeast', variety: 'Kolsch 2565' },
    { brand: 'Wyeast', variety: 'Bohemian Lager 2124' },
    { brand: 'Wyeast', variety: 'American Wheat 1010' },
    { brand: 'Wyeast', variety: 'British Ale 1098' },
    { brand: 'White Labs', variety: 'California Ale WLP001' },
    { brand: 'White Labs', variety: 'English Ale WLP002' },
    { brand: 'White Labs', variety: 'East Coast Ale WLP008' },
    { brand: 'White Labs', variety: 'Pacific Ale WLP041' },
    { brand: 'White Labs', variety: 'Pilsner Lager WLP800' }
    ])

#Styles
  styles = Style.create([
    { name: 'Czech Lager' },
    { name: 'IPA' },
    { name: 'Pale Ale' },
    { name: 'Stout' },
    { name: 'Porter' },
    { name: 'Strong Ale' },
    { name: 'Belgian Trippel' },
    { name: 'Brown' },
    { name: 'Kolsch' },
    { name: 'Maibock' },
    { name: 'Pilsner' },
    { name: 'German Lager' },
    { name: 'ESB' },
    { name: 'Amber Ale' },
    { name: 'Hefeweizen' },
    { name: 'Wheat Beer' },
    { name: 'American Lager' },
    { name: 'Cream Ale' }
    ])
