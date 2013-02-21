class Shell < ActiveRecord::Base
  belongs_to :recruiter
  attr_accessible :code_buffer

  @result = ""

  def self.call_eval(code)

    ActiveRecord::Base.class_eval do
      alias_method :old_readonly?, :readonly?

      def readonly?
        true
      end
    end

    begin
      raise SecurityError.new("Don't touch my DB!") if code =~ /update|create|destroy|delete|save/i
      raise SecuriryError.new("/!\\ No meta programming, it's dangerous /!\\") if code =~ /send|method|call/i
      proc {
        $SAFE = 3
        ActiveRecord::Base.transaction do
          @result = eval(code)
          raise ActiveRecord::Rollback.new
        end
      }.call
    rescue SecurityError => e
      @result = "Gotcha! Hackers gonna hack => #{e.inspect}"
    rescue SyntaxError => e
      @result = "Syntax Error => #{e.inspect}"
    rescue Exception => e
      @result = "Unknown exception => #{e}"
    end

    ActiveRecord::Base.class_eval do
      alias_method :readonly?, :old_readonly?
    end

    @result

  end
end
