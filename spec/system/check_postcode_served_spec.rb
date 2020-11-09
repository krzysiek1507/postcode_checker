# frozen_string_literal: true

require 'rails_helper'

describe 'User checks postcode is served', type: :system, vcr: true do
  before { driven_by(:rack_test) }

  context 'when postcode is served' do
    it 'displays that postcode is served' do
      visit '/postcodes/check'

      fill_in :postcode, with: 'SE1 7QD'
      click_button 'Check'

      expect(page).to have_text 'We serve this postcode'
    end
  end

  context 'when postcode is not served' do
    it 'displays that postcode is not served' do
      visit '/postcodes/check'

      fill_in :postcode, with: 'SE1 7QDAAAA'
      click_button 'Check'

      expect(page).to have_text "Unfortunately, we don't serve this postcode"
    end
  end
end
