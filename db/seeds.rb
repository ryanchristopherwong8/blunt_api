# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
prng = Random.new
100.times do |i|
   User.create(:id => "#{i}", :email => "User#{i}@gmail.com", 
   	:latitude => (((-90)-90)*prng.rand + 90), :longitude => (((-180)-180)*prng.rand + 180))
   sp = SeekingProfile.where(user_id: "#{i}")
   sp.update_all(:minSeekDistance => rand(0...20), :maxSeekDistance => rand(30...100))
end