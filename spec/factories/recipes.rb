# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  name        :string           not null
#  description :text             not null
#  ingredients :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
FactoryBot.define do
  factory :recipe do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    ingredients { Faker::Lorem.paragraph }
    user
  end
end
