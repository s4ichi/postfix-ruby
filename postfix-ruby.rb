# frozen_string_literal: true

module PostFix
  module Instruction
    def n(i)
      raise 'Not a number' unless number?(i)
      stack.push(i)
    end

    def add
      raise 'Not enough numbers to add' if stack.length < 2
      v2, v1 = stack.pop(2)
      stack.push(v1 + v2)
    end

    def sub
      raise 'Not enough numbers to sub' if stack.length < 2
      v2, v1 = stack.pop(2)
      stack.push(v2 - v1)
    end

    def mul
      raise 'Not enough numbers to mul' if stack.length < 2
      v2, v1 = stack.pop(2)
      stack.push(v2 * v1)
    end

    def div
      raise 'Not enough numbers to div' if stack.length < 2
      v2, v1 = stack.pop(2)
      raise 'Divide by 0' if v1 == 0
      stack.push(v2 / v1)
    end

    def rem
      raise 'Not enough numbers to rem' if stack.length < 2
      v2, v1 = stack.pop(2)
      raise 'Divide by 0' if v1 == 0
      stack.push(v2 % v1)
    end

    def lt
      raise 'Not enough numbers to lt' if stack.length < 2
      v2, v1 = stack.pop(2)
      stack.push(v2 < v1 ? 1 : 0)
    end

    def pop
      raise 'Not enough numbers to pop' if stack.empty?
      stack.pop
    end

    def swap
      raise 'Not enough numbers to swap' if stack.length < 2
      v2, v1 = stack.pop(2)
      stack.push(v1, v2)
    end

    def sel
      raise 'Not enough numbers to sel' if stack.length < 2
      v = stack.pop(3)
      v1 = v[2]; v2 = v[1]; v3 = v[0];
      raise 'Not a number' unless number?(v3)
      stack.push(v3 == 0 ? v1 : v2)
    end

    def nget
      raise 'Not enough numbers to nget' if stack.empty?
      v_index = stack.pop
      raise 'Not a number' unless number?(v_index)
      raise "Index #{v_index} is too large" if stack.length < v_index
      raise "Index #{v_index} is too small" if v_index < 1
      stack.push(stack[stack.length - v_index])
    end

    def command(&blk)
      stack.push(blk)
    end

    def exec
      raise 'Not enough numbers to exec' if stack.empty?
      command = stack.pop
      self.instance_eval(&command)
    end
  end

  class Program
    include Instruction

    def initialize
      @stack = []
    end

    def eval(argv, &body)
      @stack = argv
      instance_eval(&body)

      raise 'Stack is empty' if stack.empty?
      stack.pop
    end

    private

    def stack
      @stack
    end

    def number?(v)
      v.is_a?(Integer)
    end
  end
end
