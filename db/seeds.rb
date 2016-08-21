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
   	:latitude =>  (((-90)-90)*prng.rand + 90), :longitude => (((-180)-180)*prng.rand + 180), :facebook_id => "#{i}")
   sp = SeekingProfile.where(user_id: "#{i}")
   sp.update_all(:minSeekDistance => rand(0...20), :maxSeekDistance => rand(30...100))
end

#User.create(:id => "1", :email => "user1@gmail.com", :latitude => "49.228107", :longitude => "-123.072819")
#SeekingProfile.where(user_id: "1").update_all(:minSeekDistance => 20, :maxSeekDistance => 60)

#User.create(:id => "2", :email => "user2@gmail.com", :latitude => "49.248562", :longitude => "-123.076047")
#SeekingProfile.where(user_id: "2").update_all(:minSeekDistance => 20, :maxSeekDistance => 60)

#User.create(:id => "3", :email => "user3@gmail.com", :latitude => "75.888233", :longitude => "-123.111111"	)
#SeekingProfile.where(user_id: "3").update_all(:minSeekDistance => 20, :maxSeekDistance => 60)