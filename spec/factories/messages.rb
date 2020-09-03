FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}  #Fakerでダミーデータ作成（短文）※複数のデータを作れる
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
                     #↑Rails.rootの意味は/Users/~~/アプリケーションまでのパスを取得
                     #ダミー画像を設定

    user   #user_idが反映
    group   #group_idが反映
  end
end