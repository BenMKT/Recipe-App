FactoryBot.define do
  factory :recipe do
    name { 'Delicious Recipe' }
    description { 'This is a tasty recipe.' }
    user
  end
end
