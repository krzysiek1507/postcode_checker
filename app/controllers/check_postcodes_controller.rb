# frozen_string_literal: true

class CheckPostcodesController < ApplicationController
  def check
    @postcode_allowed = ::CheckPostcodeAllowed.call params[:postcode]
  end
end
