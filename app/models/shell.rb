class Shell
  require 'stringio'

  attr_accessor :result, :status

  def initialize(code)
    @result = ""
    @code = code
    @string_io = StringIO.new
    @std_out = $stdout
    @status = ""
  end

  def call_eval
    prepare_shell_and_catch_exceptions do
      get_proc_eval.call
    end
    @result
  end

  def string_io_as_string
    @string_io.string.gsub("\n", "")
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
      ActiveRecord::Base.transaction do
        @result = eval(@code)
        if @code =~ /puts|print/i
          @result = string_io_as_string
          @status = 'print'
        elsif @code =~ /[^=]=[^=]/
          @status = 'assignment'
        else
          @status = 'success'
        end
        raise ActiveRecord::Rollback.new
      end
    }
  end


  def prepare_shell_and_catch_exceptions

    staged_execution do
      begin
        check_common_hacks
        yield
      rescue SecurityError => e
        @result = SecurityError.new("Gotcha! Hackers gonna hack => #{e.message}")
        @status = "exception"
      rescue SyntaxError => e
        @result = SyntaxError.new("Syntax Error => #{e.message}")
        @status = "exception"
      rescue Exception => e
        @result = Exception.new("Unknown exception => #{e.message}")
        @status = "exception"
      end
    end
  end

  def staged_execution
    prepare_execution
    yield
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
    raise SecurityError.new("/!\\ No meta programming, it's dangerous /!\\") if @code =~ /send|method|call/i
    raise SecurityError.new("/!\\ No global variables, it's dangerous /!\\") if @code =~ /\$/ && !Rails.env.test? #We're using it for some tests
  end

end
