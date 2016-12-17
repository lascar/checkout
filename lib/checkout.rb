require 'byebug'
# create a list of product and applies the pricing_rules (price and reduction's rules)
class Checkout
  # apply two4one to a price and a number of items
  two4one = -> (num, price) do
    items_par, remain = num.divmod(2)
    (remain + items_par) * price
  end

  # apply minus1up22 to a price and a number of items
  minus1up22 = -> (num, price) do
    num == 1 ? price : price + ((num - 1) * (price - 100))
  end

  REDUCTION = {
    two4one: two4one,
    minus1up22: minus1up22
  }

  def initialize(pricing_rules)
    @items_scan = Hash.new(0)
    @reductions = pricing_rules[:reductions]
    @prices = pricing_rules[:prices]
  end

  def scan(product)
    @items_scan[product] += 1
  end

  def total_price
    amount = 0
    @items_scan.each do |item, num|
      amount += total_price_for_item(num, item)
    end
    return amount
  end

  private
  def total_price_for_item(num, item)
    reduction = REDUCTION[@reductions[item]]
    price = @prices[item]
    !!reduction ? reduction.call(num, price) : (price * num)
  end
end
