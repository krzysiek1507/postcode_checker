# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/postcodes/check(/:postcode)', to: 'check_postcodes#check', as: :check_postcode
end
