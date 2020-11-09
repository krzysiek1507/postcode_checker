# frozen_string_literal: true

module Postcodes
  class FetchPostcodeDetails
    class << self
      def call(postcode)
        ::Postcodes::Postcode.from_json response(postcode.delete(" \t\r\n"))
      end

      private

      API_URL = 'https://api.postcodes.io/postcodes'
      EXPECTED_RESPONSE_STATUSES = [200].freeze

      private_constant :EXPECTED_RESPONSE_STATUSES

      def response(postcode)
        Excon
          .get("#{API_URL}/#{postcode}", expects: EXPECTED_RESPONSE_STATUSES)
          .then { |response| JSON.parse(response.body, symbolize_names: true)[:result] }
      end
    end
  end
end
