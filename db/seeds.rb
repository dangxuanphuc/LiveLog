puts "Starting Faker..."

def nendo date = Date.today
  if date.mon < 4
    date.year - 1
  else
    date.year
  end
end

User.create!(first_name: "Phuc",
  last_name: "Dang Xuan",
  furigana: "wataridori",
  nickname: "wataridori",
  email: "admin@gmail.com",
  password: "admin000",
  password_confirmation: "admin000",
  admin: true,
  joined: nendo(Date.today)-1)

puts "Faker is generating data ... Please wait..."

19.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  furigana = Faker::Name.middle_name
  nickname = Faker::Name.female_first_name
  email = "user-#{n+1}@gmail.com"
  password = "123456"
  User.create!(first_name: first_name,
    last_name: last_name,
    furigana: furigana,
    nickname: nickname,
    email: email,
    password: password,
    password_confirmation: password,
    joined: nendo(Date.today))
end

puts "Create #{User.count} users!"
