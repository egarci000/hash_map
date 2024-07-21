# error to raise when trying to access out of bound index
# raise IndexError if index.negative? || index >= @buckets.length

# to do: add linkedList functionality to hashmap, linking key/value pairs to a hash code generated from the key

# new_arr = Array.new(3)

# new_arr[4] = {"hi"=>320}

# p new_arr

# return

class HashMap

  attr_accessor :buckets

  def initialize(size=16)
    @size = size
    @load_factor = 0.85
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

  def set(key, value)
    index = hash(key) % 16
    k_v_pair = {key => value}

    if @buckets[index] == nil
      @buckets[index] = LinkedList.new
      @buckets[index].append(k_v_pair)
    else
      @buckets[index].append(k_v_pair)
    end
  end

  def get(key)
    index = hash(key) % 16
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
    @buckets.each {|elem| keys_arr << elem.keys if elem != nil}
    keys_arr = keys_arr.flatten
    return puts true if keys_arr.include?(key)
    puts false
  end


  #takes a key as an argument. If the given key is in the hash map, it should remove the entry with that key
  #and return the deleted entry’s value. If the key isn’t in the hash map, it should return nil.
  def remove(key)
  end

  def get_keys
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.keys if elem != nil}
    p keys_arr.flatten
  end

  def get_values
    values_arr = []
    @buckets.each {|elem| values_arr << elem.values if elem != nil}
    p values_arr.flatten
  end

  def get_num_of_keys
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.keys if elem != nil}
    puts keys_arr.flatten.length
  end

  #returns an array that includes each key value pair
  def get_entries
    entries_arr = []
    @buckets.each {|elem| entries_arr << elem.entries if elem != nil}
    p entries_arr.flatten(1)
  end

  def get_size
    keys_arr = []
    @buckets.each {|elem| keys_arr << elem.keys if elem != nil}
    size = keys_arr.flatten.length
  end

  def grow_buckets
    size = get_size
    #double buckets when size is more than 16 * load_factor (0.85)
    #set new size of buckets to double its previous value when size is more than 16 * @load_factor.
    #Then rearrange values in buckets according to the new
    #bucket order of hash code mod new @size
    if size >= @size * @load_factor
      @size = @size * 2
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
      check_pair = node.value.to_s.tr('{}""',"").split("=>")
      return check_pair[1] if check_pair[0] == key
      node = node.nextNode
    end
    nil
  end

  def to_s
    node = self.head
    list_to_s = ""
    while(!node.nil?)
      if node.nextNode == nil
        list_to_s += "(#{node.value}) -> nil"
      else
        list_to_s += "(#{node.value}) -> "
      end
      node = node.nextNode
    end
    list_to_s
  end

  def keys
    node = self.head
    keys_arr = []
    while(!node.nil?)
      k_v_pair = node.value.to_s.tr('{}""',"").split("=>")
      if node != nil
        keys_arr << k_v_pair[0]
      end
      node = node.nextNode
    end
    keys_arr
  end

  def values
    node = self.head
    values_arr = []
    while(!node.nil?)
      k_v_pair = node.value.to_s.tr('{}""',"").split("=>")
      if node != nil
        values_arr << k_v_pair[1]
      end
      node = node.nextNode
    end
    values_arr
  end

  def entries
    node = self.head
    entries_arr = []
    while(!node.nil?)
      k_v_pair = node.value.to_s.tr('{}""',"").split("=>")
      if node != nil
        entries_arr << [k_v_pair[0]] + [k_v_pair[1]]
      end
      node = node.nextNode
    end
    entries_arr
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

new_key = HashMap.new

new_key.set("12", "shupppp world")
new_key.set("352", "world")
new_key.set("key", "shup")
new_key.set("352", "352")

new_key.get("key")
new_key.has?("12")
new_key.get_keys
new_key.get_values
new_key.get_num_of_keys
new_key.get_entries
