FactoryBot.define do
  factory :recipe_food do
    # Add attributes for recipe_food here
    # For example:
    association :recipe
    association :food
    quantity { 1 }
  end
end
