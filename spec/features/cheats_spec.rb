require 'spec_helper'
describe "CheatsSpec" do
  before(:each) do
  #  login_as Recruiter.first, scope: :recruiter, :run_callbacks => false
    visit shell_index_path
  end
  #
  #after(:each) do
  #  Warden.test_reset!
  #end

  #it "allows shell access" do
  #  page.should have_css "#shell_container"
  #end
  #
  #
  CandidateDecorator::SECTIONS.each do |section|
  it "displays #{section} modal box", js: true do
      click_link section
      page.should have_css ".modal.#{section}"
    end
  end


end