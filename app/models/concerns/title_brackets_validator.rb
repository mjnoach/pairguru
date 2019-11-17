class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)    
    if !title_valid? record.title
      record.errors.add(:title, "All brackets should be closed and can't be empty")
    end
  end

  private

  def title_valid? title
    !empty_brackets?(title) && closed_brackets?(title)
  end

  def empty_brackets? string
    string.include?("()") || string.include?("{}") || string.include?("[]")
  end

  def closed_brackets? string
    counter = { "()" => 0, "{}" => 0, "[]" => 0 }

    string.each_char do |c|
      case c
      when '('
        counter["()"] += 1
      when ')'
        counter["()"] -= 1
      when '{'
        counter["{}"] += 1
      when '}'
        counter["{}"] -= 1
      when '['
        counter["[]"] += 1
      when ']'
        counter["[]"] -= 1        
      end
      return false if counter.values.any? { |num| num < 0 }
    end

    return counter.values.any? { |num| num != 0 } ? false : true
  end
end