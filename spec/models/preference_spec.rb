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

describe Preference do
  describe 'validations' do
    subject { build(:preference) }

    let(:user) { create(:user) }

    it 'is valid with a name, description and restriction' do
      expect(subject).to be_valid
    end
  end
end
