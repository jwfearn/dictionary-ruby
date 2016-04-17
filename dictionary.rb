class LinkedListDictionary
  def initialize
    @last = @head = nil
  end

  def set(k, v) # O(n)
    changed = false
    node = get_node(k)
    if node
      node[1] = v
      changed = true
    else
      node = [k, v, nil]
      @head = node unless @head
      @last[2] = node if @last
      @last = node
    end
    changed
  end

  def get(k) # O(n)
    node = get_node(k)
    raise(KeyError, k) unless node
    node[1]
  end

  def keys
    return to_enum(__callee__) unless block_given?
    nodes.each { |n| yield n[1] }
  end

  private

  def nodes
    return to_enum(__callee__) unless block_given?
    node = @head
    while node
      yield node
      node = node[2]
    end
  end

  def get_node(k) # O(n)
    nodes.find { |node| node[0] == k }
  end
end

class HashTableDictionary
  def initialize
    @buckets = []
    @keys = []
  end

  def set(k, v)
    i = self.class.hash_function(k)
    bucket = @buckets[i] ||= LinkedListDictionary.new
    changed = bucket.set(k, v)
    @keys << k unless changed
    changed
  end

  def get(k)
    i = self.class.hash_function(k)
    bucket = @buckets[i]
    raise(KeyError, k) unless bucket
    bucket.get(k)
  end

  def keys
    @keys.each
  end

  def self.hash_function(k) # O(1)
    k.hash & 0xFF
  end
end
