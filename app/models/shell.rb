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

  def last_command
    @code.split(";").last
  end

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
        if last_command =~ /puts|print/i
          @result = string_io_as_string
          @status = 'print'
        elsif last_command =~ /[^=]=[^=]/
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
        @result = SecurityError.new("#{I18n.t("shell.exceptions.security")} => #{e.message}")
        @status = "exception"
      rescue SyntaxError => e
        @result = SyntaxError.new("#{I18n.t("shell.exceptions.syntax")} => #{e.message}")
        @status = "exception"
      rescue Exception => e
        @result = Exception.new("#{I18n.t("shell.exceptions.unknown")} =>  #{e.message}")
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
    raise SecurityError.new(I18n.t("shell.exceptions.db")) if @code =~ /update|create|destroy|delete|save/i
    raise SecurityError.new(I18n.t("shell.exceptions.system")) if @code =~ /system|\`|%x|File|IO|Dir|syscall|exec|Open3/
    raise SecurityError.new(I18n.t("shell.exceptions.meta")) if @code =~ /send|method|call|eval|constantize|const_get/i
    raise SecurityError.new(I18n.t("shell.exceptions.global")) if @code =~ /\$/ && !Rails.env.test? #We're using it for some tests
  end

end
