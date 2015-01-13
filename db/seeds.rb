require 'buzzfeed_title_generator'

authors = [
  'Aaron Black',
  'Alex Schattner',
  'Amanda Trexler',
  'Caroline Morgan',
  'David Brodsky',
  'Emily Connors',
  'Ian Glover',
  'Jackson Lee',
  'Jamie Yerushalmi',
  'Lauren Levine',
  'Luis Jaramillo',
  'Matthew Smith',
  'Margaret Huang',
  'Mikhail Firer',
  'Nidhi Shah',
  'Patricia Goodall',
  'Rebecca Wong',
  'Ross Wittenberg',
  'Sam Matthews',
  'Sheri Grossman',
  'Tony DeFreitas',
  'William Shaw'
]


Hoot.destroy_all
100.times do
  Hoot.create!(author: authors.sample, content: BuzzfeedTitleGenerator.make_title)
end