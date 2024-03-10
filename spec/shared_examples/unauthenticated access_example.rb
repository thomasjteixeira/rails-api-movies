# frozen_string_literal: true

RSpec.shared_examples 'unauthenticated access' do
  it 'redirects to the login page' do
    subject
    expect(response).to redirect_to(login_path)
  end

  it 'sets a flash alert for needing login' do
    subject
    expect(flash[:alert]).to eq('You must be logged in to access this page')
  end
end
