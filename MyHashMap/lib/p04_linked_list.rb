class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail, :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head
  end

  def last
    tail
  end

  def empty?
    head.nil?
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    each{|link| return true if link.key == key}
    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    return false if include?(key)
    if empty?
      self.head = new_link
      self.tail = new_link
    else
      self.tail.next = new_link
      new_link.prev = tail
      self.tail = new_link
    end
  end

  def remove(key)
    each do |link|
      if link.key == key
        if link == head
          self.head = link.next
          link.next.prev = nil
          link.next = nil
        elsif link == tail
          self.tail = link.prev
          link.prev.next = nil
          link.prev = nil
        else
          link.prev.next = link.next
          link.next.prev = link.prev
          link.prev = nil
          link.next = nil
        end
        return link
      end
    end
  end

  def each(&prc)
    return if empty?
    link = head
    loop do
      prc.call(link)
      break if link.next.nil?
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
