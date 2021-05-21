# frozen_string_literal: true

# Classe que representa o cliente, com seu ID e tamanho
class Cliente
  attr_reader :id, :tamanho

  def initialize(id, tamanho)
    raise ArgumentError, 'ID deve ser numérico e estar entre 0 e 1.000.000' unless (0..1_000_000).include?(id)
    unless (0..1_000).include?(tamanho)
      raise ArgumentError, 'O tamanho do cliente deve ser numérico e estar entre 0 e 100.000'
    end

    @id = id
    @tamanho = tamanho
  end
end
