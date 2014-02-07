# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pet.delete_all
Pet.create!(name: 'Clifford',
  age: 4,
  breed: 'Boston Terrier',
  description: 'Rambunctious young Boston. Great with kids, slightly scared of cats',
  image_url: 'Clifford.jpg')

Pet.create!(name: 'Toby',
  age: 1,
  breed: 'Unknown',
  description: 'Active young kitten, too smart for his own good',
  image_url: 'Toby.jpg')