module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Alt-Fuel-Finder"
    end
  end
end
