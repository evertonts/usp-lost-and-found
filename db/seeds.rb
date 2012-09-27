# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.name
user.add_role :admin
user2.add_role :site_user


puts 'CREATING EXAMPLE ITEMS'
item = Item.new title: "[test] Carteira", description: "Carteira preta com detalhes marrons", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: true
item.user = user
item.save!

item = Item.new title: "[test] Oculos", description: "Oculos preto perdido no IME", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: true
item.user = user2
item.save!

item = Item.new title: "[test] Blusa", description: "Blusa azul da GAP perdida na FEA", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: true
item.user = user
item.save!

item = Item.new title: "[test] Estojo", description: "Estojo azul com ziper preto", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: true
item.user = user2
item.save!

item = Item.new title: "[test] Mochila", description: "Mochila amarela", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: true
item.user = user
item.save!

item = Item.new title: "[test] Carteira", description: "Carteira preta com detalhes marrons", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: false
item.user = user2
item.save!

item = Item.new title: "[test] Oculos", description: "Oculos preto perdido no IME", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: false
item.user = user
item.save!

item = Item.new title: "[test] Blusa", description: "Blusa azul da GAP perdida na FEA", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: false
item.user = user2
item.save!

item = Item.new title: "[test] Estojo", description: "Estojo azul com ziper preto", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: false
item.user = user
item.save!

item = Item.new title: "[test] Mochila", description: "Mochila amarela", lost_date: Time.now.to_date.strftime("%d/%m/%Y"), lost: false
item.user = user2
item.save!