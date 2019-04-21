# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::Distance do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  # TODO: Write test code
  #
  # For example
  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<-RUBY.strip_indent)
      describe Some::Class do
        let(:foo_1) { 1 }
        ^^^^^^^^^^^ Too far.
        let(:foo_2) { 1 }
        let(:foo_3) { 1 }
        let(:foo_4) { 1 }
        let(:foo_5) { 1 }
        let(:foo_6) { 1 }
        let(:foo_7) { 1 }
        let(:foo_8) { 1 }
        let(:foo_9) { 1 }
        let(:foo_10) { 1 }
        let(:foo_11) { 1 }
        describe "a describe" do
          it { is_expected.to eq(1) }
        end
      end
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<-RUBY.strip_indent)
      describe Some::Class do
        describe "a describe" do
          it { is_expected.to eq(1) }
        end
      end
    RUBY
  end
end
