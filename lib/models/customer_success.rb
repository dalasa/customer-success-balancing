# frozen_string_literal: true

class CustomerSuccess
  attr_reader :id, :nivel


  def initialize(id, nivel)
    raise ArgumentError, 'ID deve ser numérico e estar entre 0 e 1.000' unless (0..1_000).include?(id)
    raise ArgumentError, 'O nivel do CS deve ser numérico e estar entre 0 e 10.000' unless (0..10_000).include?(nivel)

    @id = id
    @nivel = nivel
  end
end
