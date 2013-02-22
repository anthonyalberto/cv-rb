require 'spec_helper'

describe Shell do
  
  context "Regular command" do
    before(:each) do
      @shell = Shell.new("Recruiter.first")
      @result = @shell.call_eval
    end
    it "gives an object" do
      @result.should be_a_kind_of(Recruiter)
    end
    it "sets the status to success" do
      @shell.status.should == "success"
    end
  end

  context "Print/Puts command" do
    before(:each) do
      @shell = Shell.new("puts 'hello'")
      @result = @shell.call_eval
    end
    it "gives the output stream" do
      @result.should == @shell.string_io_as_string
    end
    it "sets the status to print" do
      @shell.status.should == "print"
    end
  end

  context "Assignment command" do
    before(:each) do
      @shell = Shell.new("$recruiter = Recruiter.first")
      @result = @shell.call_eval
    end
    it "sets the status to assignment" do
      @shell.status.should == "assignment"
    end
    it "assigns the object" do
      $recruiter.should == Recruiter.first
    end
  end

  context "Invalid command" do
    before(:each) do
      @shell = Shell.new("lol")
      @result = @shell.call_eval
    end
    it "sets the status to exception" do
      @shell.status.should == "exception"
    end
    it "gives an exception object" do
      @result.should be_a_kind_of Exception
    end
  end

  context "Security errors" do
    it "rejects DB change methods" do
      @result = Shell.new("Recruiter.destroy_all").call_eval
      @result.should be_a_kind_of SecurityError
    end
    it "rejects common meta-programming methods" do
      @result = Shell.new("Object.send('id')").call_eval
      @result.should be_a_kind_of SecurityError
    end
  end

end
