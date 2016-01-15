class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.to_s.hash
  end
end

class String
  def hash
    self.unpack("s5").map{|el| el.nil? ? 1.hash : el.hash}.inject(:+)
  end
end

class Hash
  def hash
    self.to_a.flatten.map{|i| i.to_s}.sort.hash
  end
end
