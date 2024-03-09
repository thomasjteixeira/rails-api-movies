require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'BD indexes' do
    context 'on movies.created_at column' do
      subject { ActiveRecord::Base.connection.index_exists?(:movies, :created_at) }
    end
  end

  it 'existe to improve query performance' do
    is_expected.to be_truthy
  end
end
