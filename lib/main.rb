# error to raise when trying to access out of bound index
# raise IndexError if index.negative? || index >= @buckets.length

# need to fix collisions, get_entries returns wrong key value pairs, returning some entries as [key, key of another key/value pair]

class HashMap

  attr_accessor :buckets

  def initialize(size=16)
    @size = size
    @load_factor = 0.75
    @buckets = Array.new(@size)
  end

  def hash(key)
    hash_code = 0.77522
    prime_number = 31
    key.each_char {|char| hash_code = prime_number * hash_code + char.ord}
    hash_code_arr = hash_code.to_s.split(".")
    hash_code = hash_code_arr[0].to_i * hash_code_arr[1].to_i
    hash_code
  end

  def set(key, value, cleared=nil)
    if is_over_size == true && cleared == nil
      grow_buckets
    end
    index = hash(key) % @size
    k_v_pair = {key => value}
    if @buckets[index] == nil
      @buckets[index] = LinkedList.new
      @buckets[index].append(k_v_pair)
    else
      @buckets[index].append(k_v_pair)
    end
  end

  def get(key)
    index = hash(key) % @size
    begin
      found_key_value = @buckets[index].find(key)
    rescue NoMethodError
      puts nil
    else
      puts found_key_value
    end
  end

  def has?(key)
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.get_k_v_entries("keys") if elem != nil}
    keys_arr = keys_arr.flatten
    return puts true if keys_arr.include?(key)
    puts false
  end

  def remove(key)
    index = hash(key) % @size
    puts @buckets[index].remove(key)
  end

  def clear_hash_map
    @buckets.compact!
    @buckets.each {|entry| entry.clear}
  end

  def get_keys
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.get_k_v_entries("keys") if elem != nil}
    p keys_arr.flatten
  end

  def get_values
    values_arr = []
    @buckets.each {|elem| values_arr << elem.get_k_v_entries("values") if elem != nil}
    p values_arr.flatten
  end

  def get_num_of_keys
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.get_k_v_entries("keys") if elem != nil}
    puts keys_arr.flatten.length
  end

  def get_entries
    entries_arr = []
    @buckets.each {|elem| entries_arr << elem.get_k_v_entries("entries") if elem != nil}
    p entries_arr.flatten(1)
  end

  def is_over_size
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.get_k_v_entries("keys") if elem != nil}
    size = keys_arr.flatten.length
    if size >= (@size * @load_factor).ceil
      return true
    end
    false
  end

  def grow_buckets
    @size = @size * 2
    temp_buckets = @buckets
    temp_buckets_compact = temp_buckets.compact
    temp_buckets_size = temp_buckets_compact.length
    @buckets = Array.new(@size)
    rearrange_entries(temp_buckets)
  end

  def rearrange_entries(buckets)
    temp_buckets = buckets
    entries_arr = []
    temp_buckets.each do |entry|
      if entry != nil
        k_v_pair = entry.get_k_v_entries("entries")
        entries_arr << k_v_pair
      end
    end
    entries_arr = entries_arr.flatten(2)
    times_run_loop = entries_arr.length/2
    index=*(0..entries_arr.length)

    while times_run_loop > 0
      set(entries_arr[index[0]], entries_arr[index[1]], true)
      index.slice!(0..1)
      times_run_loop -= 1
    end
  end

end

class LinkedList
  attr_accessor :head

  def initialize
    self.head = head
  end

  def append(value)
    if self.head.nil?
      self.head = Node.new(value, nil)
    else
      lastNode = self.head
      while(!lastNode.nextNode.nil?)
        lastNode = lastNode.nextNode
      end
      #we're at the end of the list
      lastNode.nextNode = Node.new(value, nil)
    end
  end

  def find(key)
    node = self.head
    while(!node.nil?)
      k_v_pair = node.value.to_s.tr('{}""',"").split("=>")
      return k_v_pair[1] if k_v_pair[0] == key
      node = node.nextNode
    end
    nil
  end

  def remove(key_value)
    node = self.head
    count = 1
    while(!node.nil?)
      k_v_pair = node.value.to_s.tr('{}""',"").split("=>")
      if key_value == k_v_pair[0] && count == 1
        self.head = node.nextNode
        return k_v_pair[1]
      elsif key_value == k_v_pair[0] && count > 1
        node.nextNode = node.nextNode.nextNode
        return k_v_pair[1]
      end
      node = node.nextNode
      count += 1
    end
  end

  def clear
    self.head = nil
  end

  def get_k_v_entries(value)
    node = self.head
    container_arr = []
    while(!node.nil?)
      k_v_pair = node.value.to_s.tr('{}""',"").split("=>")
      if node != nil
        container_arr << k_v_pair[0] if value == "keys"
        container_arr << k_v_pair[1] if value == "values"
        container_arr << [k_v_pair[0], k_v_pair[1]] if value == "entries"
      end
      node = node.nextNode
    end
    container_arr
  end

  private
  class Node
    attr_accessor :value, :nextNode

    def initialize(value, nextNode)
      self.value = value
      self.nextNode = nextNode
    end
  end
end

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('moon', 'silver')

test.get_entries
