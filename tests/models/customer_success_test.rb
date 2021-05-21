# frozen_string_literal: true

require_relative '../../lib/models/customer_success'
require 'minitest/autorun'

# rubocop:disable Metrics/BlockLength
describe CustomerSuccess do
  describe 'quando cria uma nova instancia' do
    subject { CustomerSuccess.new(id, nivel) }

    let(:id) { 10 }
    let(:nivel) { 100 }

    describe 'com dados corretos' do
      it 'retorna uma nova instancia com o id informado' do
        _(subject.id).must_equal(id)
      end

      it 'retorna uma nova instancia com o nivel informado' do
        _(subject.nivel).must_equal(nivel)
      end
    end

    describe 'com dados incorretos' do
      describe 'com um id fora do range' do
        let(:id) { -1 }

        it 'lança um ArgumentError com a mensagem correta' do
          assert_raises(ArgumentError, 'ID deve ser numérico e estar entre 0 e 1.000') { subject }
        end
      end

      describe 'com um nivel fora do range' do
        let(:nivel) { '-1' }

        it 'lança um ArgumentError com a mensagem correta' do
          assert_raises(ArgumentError, 'O nivel do CS deve ser numérico e estar entre 0 e 10.000') { subject }
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
