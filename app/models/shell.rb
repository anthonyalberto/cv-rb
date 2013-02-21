class Shell
  require 'stringio'

  attr_accessor :result

  def initialize(code)
    @result = ""
    @code = code
    @string_io = StringIO.new
    @std_out = $stdout
  end

  def call_eval
    prepare_shell_and_catch_exceptions do
      proc = get_proc_eval
      proc.call
    end

    @result
  end

  private

  def self.force_ar_readonly

    ActiveRecord::Base.class_eval do
      alias_method :old_readonly?, :readonly?

      def readonly?
        true
      end
    end

  end

  def self.release_ar_readonly
    ActiveRecord::Base.class_eval do
      alias_method :readonly?, :old_readonly?
    end
  end

  def get_proc_eval
    proc {
      $SAFE = 3
      ActiveRecord::Base.transaction do
        @result = eval(@code)
        @result = @string_io.string.gsub("\n", "") if @code =~ /puts|print/i
        raise ActiveRecord::Rollback.new
      end
    }
  end

  def prepare_shell_and_catch_exceptions
    prepare_execution
    begin
      check_common_hacks
      yield
    rescue SecurityError => e
      @result = "Gotcha! Hackers gonna hack => #{e.inspect}"
    rescue SyntaxError => e
      @result = "Syntax Error => #{e.inspect}"
    rescue Exception => e
      @result = "Unknown exception => #{e}"
    end
    end_execution
  end

  def prepare_execution
    Shell.force_ar_readonly
    redirect_std_out_to_string_io
  end

  def end_execution
    Shell.release_ar_readonly
    redirect_std_out_back
  end

  def redirect_std_out_to_string_io
    $stdout = @string_io
  end

  def redirect_std_out_back
    $stdout = @std_out
  end

  def check_common_hacks
    raise SecurityError.new("Don't touch my DB!") if @code =~ /update|create|destroy|delete|save/i
    raise SecuriryError.new("/!\\ No meta programming, it's dangerous /!\\") if @code =~ /send|method|call/i
  end

end
