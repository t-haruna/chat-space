FactoryBot.define do
  factory :group do
    name {Faker::Team.name} #複数のダミーデータを作成
  end
end



