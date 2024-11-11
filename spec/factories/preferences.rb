# == Schema Information
#
# Table name: preferences
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  name        :string
#  description :text
#  restriction :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_preferences_on_user_id  (user_id)
#
FactoryBot.define do
  factory :preference do
    name { Faker::Name.unique.name }
    description { 'MyText' }
    restriction { false }
    user
  end
end
