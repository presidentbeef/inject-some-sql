require 'coderay'

module ApplicationHelper
  def ruby_color code
    CodeRay.scan(code, :ruby).span.html_safe
  end

  def sql_color code
    CodeRay.scan(code, :sql).span.html_safe
  end
end
