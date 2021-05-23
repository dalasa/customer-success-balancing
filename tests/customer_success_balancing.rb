# frozen_string_literal: true

require 'minitest/autorun'
require 'timeout'

require_relative '../lib/models/customer_success.rb'

# rubocop:disable Style/Documentation
class CustomerSuccessBalancing
  def initialize(customer_success, customers, customer_success_away)
    @customer_success = customer_success
    @customers = customers
    @customer_success_away = customer_success_away
  end

  # Returns the id of the CustomerSuccess with the most customers
  def execute
    create_filtered_css_list
    distribute_customers_to_css
    get_overloaded_cs
  end

  private

  def create_filtered_css_list
    @filtered_css_list = []
    @customer_success.each do |cs|
      @filtered_css_list.push( CustomerSuccess.new(cs[:id], cs[:score]) ) unless @customer_success_away.include?(cs[:id])
    end
  end

  def distribute_customers_to_css
    @distributed_customers_to_css = Hash[@filtered_css_list.map {|cs| [cs.level, cs]}]
    css_levels = @distributed_customers_to_css.keys.sort

    @customers.each do |customer|
      selected_css_level = css_levels.bsearch { |level| level >= customer[:score] }
      @distributed_customers_to_css[selected_css_level].add_attended_customer(customer) unless selected_css_level.nil?
    end
  end

  def get_overloaded_cs
    overloaded = @distributed_customers_to_css.values.max do |a, b|
      a.attended_customers_qty <=> b.attended_customers_qty
    end
    
    overloaded_css_qty = @distributed_customers_to_css.values.count do |css|
      css.attended_customers_qty == overloaded.attended_customers_qty
    end

    return 0 if overloaded_css_qty > 1
    overloaded.id
  end
end

class CustomerSuccessBalancingTests < Minitest::Test
  def test_scenario_one
    css = [{ id: 1, score: 60 }, { id: 2, score: 20 }, { id: 3, score: 95 }, { id: 4, score: 75 }]
    customers = [{ id: 1, score: 90 }, { id: 2, score: 20 }, { id: 3, score: 70 }, { id: 4, score: 40 },
                 { id: 5, score: 60 }, { id: 6, score: 10 }]

    balancer = CustomerSuccessBalancing.new(css, customers, [2, 4])
    assert_equal 1, balancer.execute
  end

  def test_scenario_two
    css = array_to_map([11, 21, 31, 3, 4, 5])
    customers = array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60])
    balancer = CustomerSuccessBalancing.new(css, customers, [])
    assert_equal 0, balancer.execute
  end

  def test_scenario_three
    customer_success = (1..999).to_a
    customers = Array.new(10_000, 998)

    balancer = CustomerSuccessBalancing.new(array_to_map(customer_success), array_to_map(customers), [999])

    result = Timeout.timeout(1.0) { balancer.execute }
    assert_equal 998, result
  end

  def test_scenario_four
    balancer = CustomerSuccessBalancing.new(array_to_map([1, 2, 3, 4, 5, 6]),
                                            array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [])
    assert_equal 0, balancer.execute
  end

  def test_scenario_five
    balancer = CustomerSuccessBalancing.new(array_to_map([100, 2, 3, 3, 4, 5]),
                                            array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [])
    assert_equal 1, balancer.execute
  end

  def test_scenario_six
    balancer = CustomerSuccessBalancing.new(array_to_map([100, 99, 88, 3, 4, 5]),
                                            array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [1, 3, 2])
    assert_equal 0, balancer.execute
  end

  def test_scenario_seven
    balancer = CustomerSuccessBalancing.new(array_to_map([100, 99, 88, 3, 4, 5]),
                                            array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [4, 5, 6])
    assert_equal 3, balancer.execute
  end

  def array_to_map(arr)
    out = []
    arr.each_with_index { |score, index| out.push({ id: index + 1, score: score }) }
    out
  end
end

Minitest.run

# rubocop:enable Style/Documentation
