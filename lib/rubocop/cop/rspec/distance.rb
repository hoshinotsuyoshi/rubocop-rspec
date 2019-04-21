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
        MSG = 'Too far'

        def on_block(node)
          return unless example_group_with_body?(node)
          return unless describe?(node)

          # TODO: 位置的に最後のitを探す
          position = last_it_position(node.body)
          # TODO: itから上に辿った場合にダメなletを探す
          check_let_declarations(node.body)
        end

        private

        def describe?(node)
          [:context, :describe].include?(node.children.first.children[1])
        end

        def last_it_position(body)
          require'pry';binding.pry
        end

        def check_let_declarations(body)
          lets = body.each_child_node.select { |node| let?(node) }

          return
          ###
          first_let = lets.first
          lets.each_with_index do |node, idx|
            next if node.sibling_index == first_let.sibling_index + idx

            add_offense(node, location: :expression)
          end
        end
      end
    end
  end
end
