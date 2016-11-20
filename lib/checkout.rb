# apply two4one to a price and a number of items
class Two4one
  attr_reader :num
  attr_reader :price

  def initialize(num, price)
    @num = num
    @price = price
  end

  def get_price
    items_par, remain = num.divmod(2)
    (remain + items_par) * price
  end
end

# apply minus1up22 to a price and a number of items
class Minus1up2two
  attr_reader :num
  attr_reader :price

  def initialize(num, price)
    @num = num
    @price = price
  end

  def get_price
    num == 1 ? price : price + ((num - 1) * (price - 100))
  end
end

# create a list of product and applies the pricing_rules (price and reduction's rules)
class Checkout

  REDUCTION = {
    two4one: Two4one,
    minus1up22: Minus1up2two
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
    !!reduction ? reduction.new(num, price).get_price : (price * num)
  end
end
