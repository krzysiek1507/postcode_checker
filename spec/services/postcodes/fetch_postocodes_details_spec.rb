# frozen_string_literal: true

require 'rails_helper'

describe Postcodes::FetchPostcodeDetails, vcr: true do
  subject { described_class.call postcode }

  context 'when a postcode has whitespaces' do
    let(:postcode) { "SE17 \tQD\n" }

    it 'trims them and returns postcode' do
      expect(subject.postcode).to eq 'SE1 7QD'
    end
  end

  context 'when a postcode invalid' do
    let(:postcode) { 'invalid' }

    it 'raises not found' do
      expect { subject }.to raise_exception(::Excon::Error::NotFound)
    end
  end
end
