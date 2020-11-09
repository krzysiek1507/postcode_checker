# frozen_string_literal: true

require 'rails_helper'

describe CheckPostcodeAllowed do
  subject { described_class.call postcode }

  context 'when postcode is in the allowed postcodes' do
    let(:postcode) { 'SH24 1AA' }

    it 'returns true' do
      expect(subject).to eq true
    end

    context 'when postcode has different letter size' do
      let(:postcode) { 'sh241AA' }

      it 'returns true' do
        expect(subject).to eq true
      end
    end
  end

  context 'when postcode is in the allowed LSOA' do
    let(:postcode) { 'se17qd' }
    let(:postcode_details) { Postcodes::Postcode.new(lsoa: 'southwark 034A', postcode: postcode) }

    it 'returns true' do
      allow(Postcodes::FetchPostcodeDetails).to receive(:call).with('SE17QD').and_return(postcode_details)

      expect(subject).to eq true
    end
  end

  context 'when postcode is not allowed' do
    let(:postcode) { 'notallowed' }
    let(:postcode_details) { Postcodes::Postcode.new(lsoa: 'Not allowed', postcode: postcode) }

    it 'returns false' do
      allow(Postcodes::FetchPostcodeDetails).to receive(:call).with('NOTALLOWED').and_return(postcode_details)

      expect(subject).to eq false
    end
  end

  context 'when postcode is not found', vcr: true do
    let(:postcode) { 'notfound' }

    it 'returns false' do
      expect(subject).to eq false
    end
  end

  context 'when postcode is empty' do
    let(:postcode) { nil }

    it 'returns false' do
      expect(subject).to eq false
    end
  end
end
