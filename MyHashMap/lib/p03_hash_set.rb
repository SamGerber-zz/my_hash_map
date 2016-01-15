require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    resize! if count == num_buckets
    self.count = count + 1
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return false if !include?(key)
    self.count = count - 1
    self[key].delete(key)
  end

  private
  attr_accessor :store
  attr_writer :count

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    store[key.hash % store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(num_buckets * 2) { Array.new }
    self.count = 0
    old_store.each do |bucket|
      bucket.each do |key|
        insert(key)
      end
    end
    self
  end
end
