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
  email: "admin@livelog.com",
  password: "admin123",
  password_confirmation: "admin123",
  admin: true,
  joined: nendo(Date.today)-1,
  activated: true,
  activated_at: Time.zone.now)

puts "Faker is generating data ... Please wait..."

20.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  furigana = Faker::Name.middle_name
  nickname = Faker::Name.female_first_name
  email = "user-#{n+1}@gmail.com"
  password = "A123456"
  url = "https://user-#{n+1}.livelog.com"
  intro = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
  User.create!(first_name: first_name,
    last_name: last_name,
    furigana: furigana,
    nickname: nickname,
    email: email,
    password: password,
    password_confirmation: password,
    joined: nendo(Date.today),
    public: true,
    url: url,
    intro: intro,
    activated: true,
    activated_at: Time.zone.now)
end
puts "Create #{User.count} users!"

10.times do |n|
  name = Faker::Company.name
  date = Date.today
  place = Faker::Address.street_address
  Live.create!(name: name,
    date: date,
    place: place)
end
puts "Create #{Live.count} lives!"

lives = Live.order(:created_at).take(5)
21.times do |n|
  name = Faker::Music.album
  artist = Faker::Artist.name
  youtube_id = "https://www.youtube.com/watch?v=5Vr1vcsO1qI"
  order = Faker::Number.decimal_part(digits: 2)
  time = Date.today
  lives.each { |live| live.songs.create!(name: name,
    artist: artist,
    youtube_id: youtube_id,
    order: order,
    time: time
  )}
end
puts "Create #{Song.count} songs!"

insts = %w[Vo Vn Vla Vc Fl Cl Sax Tp Hr Tb Harp Gt Koto Pf Acc 鍵ハ Ba Cj Dr Bongo Perc]
21.times do |n|
  inst = insts[n]
  user_id = Faker::Number.within(range: 1..20)
  song_id = Faker::Number.within(range: 1..50)
  Playing.create!(inst: inst,
    user_id: user_id,
    song_id: song_id)
end
puts "Create #{Playing.count} playings!"
