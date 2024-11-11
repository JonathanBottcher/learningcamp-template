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

describe Recipe do
  describe 'validations' do
    subject { build(:recipe) }

    let(:user) { create(:user) }

    it 'is valid with a name, description and ingredients' do
      expect(subject).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:ingredients) }
  end
end
