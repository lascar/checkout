# create a list of product and applies the pricing_rules (price and reduction's rules)
class Checkout

  def initialize(pricing_rules)
    @items_scan = []
    @reductions = pricing_rules[:reductions]
    @prices = pricing_rules[:prices]
  end

  def scan(product)
    @items_scan << product
  end

  def total_price
    items_scaned = []
    @items_scan.inject(0) do |sum, item|
      items_scaned << item
      items_num = items_scaned.select{|item_in_select| item_in_select == item}.count
      sum = sum + fix_price_with_reduction( items_num, @prices[item], @reductions[item])
    end
  end

  private
  def fix_price_with_reduction(num, price, reduction)
    return 0 if ( reduction == :two4one && num % 2 == 0 )
    return price - 100 if ( reduction == :minus1up22 && num > 1)
    price || 0
  end
end
