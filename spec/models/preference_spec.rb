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
require 'rails_helper'

RSpec.describe Preference, type: :model do
  subject {
    Preference.new(
      name: "test",
      description: "test",
      restriction: false
    )
  }
  it 'is valid with a name' do
    expect(subject).to be_valid
  end

  it 'is invalid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
