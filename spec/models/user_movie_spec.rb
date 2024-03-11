require 'rails_helper'

RSpec.describe UserMovie, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end

  describe 'validations' do
    it { should validate_presence_of(:score) }
    it { should validate_numericality_of(:score).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:score).is_less_than_or_equal_to(10) }
  end
end
