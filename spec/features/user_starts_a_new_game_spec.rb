require 'spec_helper'

feature "User starts a new game" do
  scenario "User sees a new board of cards" do
    visit '/'

    expect(page).to have_css('div.card')

    (0..11).each do |index|
      expect(page).to have_css("div.card##{index}")
    end

  end
end
