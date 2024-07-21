class LinkedList
  attr_accessor :head

  def initialize
    self.head = nil
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

  def prepend(value)
    original_head = self.head
    self.head = Node.new(value, original_head)
  end

  def pop
    node = self.head
    while(!node.nil?)
      if node.nextNode.nextNode == nil
        node.nextNode = nil
      end
      node = node.nextNode
    end
  end

  def insert_at(value, index)
    node = self.head
    count = 1
    while(!node.nil?)
      if index == 0
        prepend(value)
        return
      elsif count == index
        node.nextNode = Node.new(value, node.nextNode)
        return
      end
      node = node.nextNode
      count += 1
    end
    puts "invalid index"
  end

  def remove_at(index)
    node = self.head
    count = 1
    while(!node.nil?)
      if index == 0
        self.head = node.nextNode
      elsif count == index
        node.nextNode = node.nextNode.nextNode
      end
      node = node.nextNode
      count += 1
    end
  end

  def size
    count = 0
    node = self.head
    while(!node.nil?)
      count += 1
      node = node.nextNode
    end
    count
  end

  def contains?(value)
    node = self.head
    while(!node.nil?)
      if(node.value == value)
        return true
      end
      node = node.nextNode
    end
    false
  end

  def at(index)
    count = 0
    node = self.head
    while(!node.nil?)
      if count == index
        return node.value
      end
      count += 1
      node = node.nextNode
    end
    puts "value not found at given index"
  end

  def find(value)
    count = 0
    node = self.head
    while(!node.nil?)
      if node.value == value
        return count
      end
      count += 1
      node = node.nextNode
    end
    puts "value not found"
  end

  def head_value
    puts self.head.value
  end

  def tail_value
    node = self.head
    while(!node.nil?)
      puts node.value if node.nextNode == nil
      return node.value if node.nextNode == nil
      node = node.nextNode
    end
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
    puts list_to_s
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

ll = LinkedList.new
ll.append("hi")
ll.append("hello")
ll.append("im last")
ll.prepend(20)
ll.prepend("in the rain, i'm singing in the rain")

ll.head_value
ll.tail_value
ll.at(5)
ll.pop
ll.find("im last")
ll.insert_at("hihi", 0)
ll.insert_at(200320, 4)
ll.remove_at(1)
ll.to_s
