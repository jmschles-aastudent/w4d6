# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( [ { :username => "bob", :password => "password" },
							 { :username => "ted", :password => "password" },
							 { :username => "jed", :password => "password" },
							 { :username => "sal", :password => "password" }
	] )

Following.create( [ { :follower_id => 1, :followed_id => 2 },
										{ :follower_id => 1, :followed_id => 3 },
										{ :follower_id => 1, :followed_id => 4 }
	] )