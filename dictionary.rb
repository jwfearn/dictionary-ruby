class LinkedListDictionary
  def initialize
    @head = nil
  end

  def set(k, v) # O(n)
    node = get_node(k)
    if node
      node[0] = k
      node[1] = v
    else
      @head = [k, v, @head]
    end
  end

  def get(k) # O(n)
    node = get_node(k)
    raise(KeyError, k) unless node
    node[1]
  end

  private

  def get_node(k) # O(n)
    node = @head
    while node
      if node[0] == k
        return node
      else
        node = node[2]
      end
    end
  end
end

class HashTableDictionary
  def initialize
    @buckets = []
  end

  def set(k, v)
    i = self.class.hash_function(k)
    bucket = @buckets[i] ||= LinkedListDictionary.new
    bucket.set(k, v)
  end

  def get(k)
    i = self.class.hash_function(k)
    bucket = @buckets[i]
    raise(KeyError, k) unless bucket
    bucket.get(k)
  end

  def self.hash_function(k) # O(1)
    k.hash & 0xFF
  end
end
