require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets
    self.count = count + 1
    delete(key)
    bucket(key).insert(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    return false if !include?(key)
    self.count = count - 1
    bucket(key).remove(key)
  end

  def each(&prc)
    store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  attr_accessor :store
  attr_writer :count

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(num_buckets * 2) { LinkedList.new }
    self.count = 0
    old_store.each do |bucket|
      bucket.each do |link|
        set(link.key, link.val)
      end
    end
    self
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    store[key.hash % store.length]
  end
end


#
#
#
# class HashSet
#   attr_reader :count
#
#   def initialize(num_buckets = 8)
#     @store = Array.new(num_buckets) { Array.new }
#     @count = 0
#   end
#
#   def insert(key)
#     return false if include?(key)
#     resize! if count == num_buckets
#     self.count = count + 1
#     self[key] << key
#   end
#
#   def include?(key)
#     self[key].include?(key)
#   end
#
#   def remove(key)
#     return false if !include?(key)
#     self.count = count - 1
#     self[key].delete(key)
#   end
#
#   private
#   attr_accessor :store
#   attr_writer :count
#
#   def [](key)
#     # optional but useful; return the bucket corresponding to `key`
#     store[key.hash % store.length]
#   end
#
#   def num_buckets
#     @store.length
#   end
#
#   def resize!
#     old_store = store
#     self.store = Array.new(num_buckets * 2) { Array.new }
#     self.count = 0
#     old_store.each do |bucket|
#       bucket.each do |key|
#         insert(key)
#       end
#     end
#     self
#   end
# end
