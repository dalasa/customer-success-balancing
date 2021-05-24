# frozen_string_literal: true

require_relative '../../lib/models/customer_success'
require 'minitest/autorun'

# rubocop:disable Metrics/BlockLength
describe CustomerSuccess do
  describe 'creating a new instance' do
    subject { CustomerSuccess.new(id, level) }

    let(:id) { 10 }
    let(:level) { 100 }

    describe 'using correct data' do
      it 'returns a new customer success instance using correct id' do
        _(subject.id).must_equal(id)
      end

      it 'returns a new customer success instance using correct level' do
        _(subject.level).must_equal(level)
      end
    end

    describe 'with invalid data' do
      describe 'using out of range id' do
        let(:id) { -1 }

        it 'throws an ArgumentError containing the right message' do
          assert_raises(ArgumentError, 'ID deve ser numérico e estar entre 0 e 1.000') { subject }
        end
      end

      describe 'using out of range level' do
        let(:level) { '-1' }

        it 'throws an ArgumentError containing the right message' do
          assert_raises(ArgumentError, 'O level do CS deve ser numérico e estar entre 0 e 10.000') { subject }
        end
      end
    end
  end

  describe 'when adds a new attended customer' do
    let(:cs) { CustomerSuccess.new(1, 1) }
    let(:customer) { [id: 1, size: 40] }

    subject { cs.add_attended_customer(customer) }

    it 'adds customer to the css custumer list' do
      subject
      _(cs.attended_customers).must_include(customer)
    end

    it 'count +1 on attended customers quantity' do
      subject
      _(cs.attended_customers_qty).must_equal(1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
