require 'spec_helper'
describe "CheatsSpec" do
  before(:each) do
    visit shell_index_path
  end

  CandidateDecorator::SECTIONS.each do |section|
    it "displays #{section} modal box", js: true do
      click_link section
      page.should have_css ".modal.#{section}"
    end
  end


end
