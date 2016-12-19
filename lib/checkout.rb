# create a list of product and applies the pricing_rules (price and reduction's rules)
class Checkout

  # apply two4one to a price and a number of items
  two4one = -> (num, price) do
    items_par, remain = num.divmod(2)
    (remain + items_par) * price
  end

  # apply minus1up2two to a price and a number of items
  minus1up2two = -> (num, price) do
    num == 1 ? price : price + ((num - 1) * (price - 100))
  end

  PRICING_RULES = Hash.new(-> (num, price) { num * price })
   .merge({
    two4one: two4one,
    minus1up22: minus1up2two
  })

  def initialize(pricing)
    @items_scan = Hash.new(0)
    @reductions = pricing[:reductions]
    @prices = pricing[:prices]
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
    reduction = PRICING_RULES[@reductions[item]]
    price = @prices[item]
    reduction.call(num, price)
  end
end
