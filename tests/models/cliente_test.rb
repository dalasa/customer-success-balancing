# frozen_string_literal: true

require_relative '../../lib/models/cliente'
require 'minitest/autorun'

# rubocop:disable Metrics/BlockLength
describe Cliente do
  describe 'quando cria uma nova instancia' do
    subject { Cliente.new(id, tamanho) }

    let(:id) { 10 }
    let(:tamanho) { 100 }

    describe 'com dados corretos' do
      it 'retorna uma nova instancia com o id informado' do
        _(subject.id).must_equal(id)
      end

      it 'retorna uma nova instancia com o tamanho informado' do
        _(subject.tamanho).must_equal(tamanho)
      end
    end

    describe 'com dados incorretos' do
      describe 'com um id fora do range' do
        let(:id) { -1 }

        it 'lança um ArgumentError com a mensagem correta' do
          assert_raises(ArgumentError, 'ID deve ser numérico e estar entre 0 e 1.000.000') { subject }
        end
      end

      describe 'com um tamanho fora do range' do
        let(:tamanho) { '-1' }

        it 'lança um ArgumentError com a mensagem correta' do
          assert_raises(ArgumentError, 'O tamanho do cliente deve ser numérico e estar entre 0 e 100.000') { subject }
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
