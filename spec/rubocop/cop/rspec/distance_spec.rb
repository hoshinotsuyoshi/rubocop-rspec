# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::Distance do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using it' do
    expect_offense(<<-RUBY.strip_indent)
      describe Some::Class do
        let(:foo_1) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_2) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_3) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_4) { 1 }
        let(:foo_5) { 1 }
        let(:foo_6) { 1 }
        let(:foo_7) { 1 }
        let(:foo_8) { 1 }
        let(:foo_9) { 1 }
        let(:foo_10) { 1 }
        let(:foo_11) { 1 }
        let(:foo_12) { 1 }

        it { is_expected.to eq(1) }
      end
    RUBY
  end

  it 'registers an offense when using it' do
    expect_offense(<<-RUBY.strip_indent)
      describe Some::Class do
        let(:foo_1) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_2) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_3) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_4) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_5) { 1 }
        ^^^^^^^^^^^^^^^^^ Declaration is too far from example.
        let(:foo_6) { 1 }
        let(:foo_7) { 1 }
        let(:foo_8) { 1 }
        let(:foo_9) { 1 }
        let(:foo_10) { 1 }
        let(:foo_11) { 1 }
        let(:foo_12) { 1 }

        describe "a describe1" do
          describe "a describe2" do
            it { is_expected.to eq(1) }
          end
        end
      end
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<-RUBY.strip_indent)
      describe Some::Class do
        let(:foo_1) { 1 }
        let(:foo_2) { 1 }
        let(:foo_3) { 1 }

        describe "a describe" do
          it { is_expected.to eq(1) }
        end
      end
    RUBY
  end
end
