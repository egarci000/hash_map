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
    # .find(key).each {|k,v| p v}
  end

  #needs work: traverse linkedlist in each bucket entry then add those entries to count
  def get_size
    count = 0
    @buckets.each {|elem| count += 1 if elem != nil}
    count
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

new_key.get("key")
