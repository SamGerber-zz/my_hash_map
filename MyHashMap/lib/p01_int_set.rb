class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    validate!(num)
    store[num]
  end

  private
  attr_reader :store

  def is_valid?(num)
    num < store.length && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
  end

  def remove(num)
    return false if !include?(num)
    self[num].delete(num)
    true
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    resize! if count == num_buckets
    self.count = count + 1
    self[num] << num
  end

  def remove(num)
    return false if !include?(num)
    self.count = count - 1
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_accessor :store
  attr_writer :count

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(num_buckets * 2) { Array.new }
    self.count = 0
    old_store.each do |bucket|
      bucket.each do |num|
        insert(num)
      end
    end
    self
  end

end
