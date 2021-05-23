# frozen_string_literal: true

class CustomerSuccess
  attr_reader :id, :level, :attended_customers_qty, :attended_customers

  def initialize(id, level)
    raise ArgumentError, 'ID deve ser numérico e estar entre 0 e 1.000' unless (0..1_000).include?(id)
    raise ArgumentError, 'O level do CS deve ser numérico e estar entre 0 e 10.000' unless (0..10_000).include?(level)

    @id = id
    @level = level
    @attended_customers_qty = 0
    @attended_customers = []
  end

  def add_attended_customer(customer)
    attended_customers.push(customer)
    @attended_customers_qty += 1
  end
end
