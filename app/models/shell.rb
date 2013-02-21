class Shell < ActiveRecord::Base
  belongs_to :recruiter
  attr_accessible :code_buffer

  def self.call_eval(code)
    begin
      raise SecurityError.new("Don't touch my DB!") if code =~ /update|create|destroy|delete|save/i
      raise SecuriryError.new("/!\\ No meta programming, it's dangerous /!\\") if code =~ /send|method|call/i
      proc {
        $SAFE = 3
        eval(code)
      }.call
    rescue SecurityError => e
      "Gotcha! Hackers gonna hack => #{e.inspect}"
    rescue SyntaxError => e
      "Syntax Error => #{e.inspect}"
    rescue Exception => e
      "Unknown exception => #{e}"
    end
  end


end
