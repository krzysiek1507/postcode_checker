# frozen_string_literal: true

class CheckPostcodeAllowed
  # Since the requirements says 'the allowed lists will need to be changed from time to time'
  # and 'from time to time' might be between never and once per era, I decided to go with the simplest solution
  # The downside of this solutions is that it requires a developer to make the change
  # The developerless solution would be to store those lists in the db and give admins a dashboard to change them

  ALLOWED_POSTCODES = %w[SH241AA SH241AB].freeze
  ALLOWED_LSOA_PREFIXES = %w[Southwark Lambeth].freeze
  DOWNCASED_ALLOWED_LSOA_PREFIXES = ALLOWED_LSOA_PREFIXES.map(&:downcase).freeze

  class << self
    def call(postcode)
      return false if postcode.blank?

      postcode = postcode.delete(" \t\r\n").upcase

      return true if ALLOWED_POSTCODES.include?(postcode) || lsoa_allowed?(postcode)

      false
    end

    private

    def lsoa_allowed?(postcode)
      ::Postcodes::FetchPostcodeDetails.call(postcode).lsoa&.downcase&.start_with?(*DOWNCASED_ALLOWED_LSOA_PREFIXES)
    rescue ::Excon::Error::NotFound
      false
    end
  end
end
