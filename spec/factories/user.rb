FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8)
    name {Faker::Team.last_name}   #複数のダミーデータを作成
    email{Faker::Internet.free_email}
    passwoed{password}    #３行目を反映
    password_confirmation{password}
  end
end