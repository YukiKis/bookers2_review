module ApplicationHelper
  def counter(num, word)
    return num.to_s + " " + word.pluralize(num)
  end
end
