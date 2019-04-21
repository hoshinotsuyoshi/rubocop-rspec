# frozen_string_literal: true

# TODO: when finished, run `rake generate_cops_documentation` to update the docs
module RuboCop
  module Cop
    module RSpec
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class Distance < Cop
        MSG = 'Declaration position is too far from example.'

        def on_block(node)
          return unless example_group_with_body?(node)
          return unless describe?(node)

          last_it = last_it(node)
          return unless last_it
          it_position = last_it_position(last_it)
          check_let_declarations(body: node.body, it_position: it_position)
        end

        private

        def describe?(node)
          [:context, :describe].include?(node.children.first.children[1])
        end

        def it?(node)
          return false if node.args_type?
          return true if [:it].include?(node.children[1])
          return false unless x = node.children.first
          [:it].include?(x.children[1])
        end

        def last_it(node)
          node.body.each_child_node.map do |node|
            if it?(node)
              node
            elsif node.block_type?
              last_it(node)
            end
          end.compact.last
        end

        def last_it_position(block_node)
          block_node.location.first_line
        end

        def check_let_declarations(body:, it_position:)
          lets = body.each_child_node.select { |node| let?(node) }

          lets.each do |let_node|
            delta = it_position - let_node.location.first_line
            next if delta <= 10
            add_offense(let_node, location: :expression)
          end
        end
      end
    end
  end
end
