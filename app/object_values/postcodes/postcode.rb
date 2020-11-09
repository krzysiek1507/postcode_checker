# frozen_string_literal: true

module Postcodes
  class Postcode
    attr_reader :lsoa, :postcode

    class << self
      def from_json(json)
        new lsoa: json[:lsoa], postcode: json[:postcode]
      end
    end

    def initialize(lsoa:, postcode:)
      @lsoa = lsoa
      @postcode = postcode
    end
  end
end
