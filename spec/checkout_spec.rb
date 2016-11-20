require 'spec_helper'
require_relative '../lib/checkout'

describe 'Two4one' do
  describe 'get_price' do
    it 'get_price return half when inizialized with an even num' do
      two4one = Two4one.new(10, 5)
      expect(two4one.get_price).to eq (25)
    end

    it 'get_price return half + 1 when inizialized with odd num' do
      two4one = Two4one.new(11, 5)
      expect(two4one.get_price).to eq (30)
    end
  end
end

describe 'Minus1up2two' do
  describe 'get_price' do
    it 'get_price return the price when inizialized with 1' do
      minus1up2two = Minus1up2two.new(1, 11)
      expect(minus1up2two.get_price).to eq (11)
    end

    it 'get_price return the price - 100 for each item up to 2' do
      minus1up2two = Minus1up2two.new(11, 2000)
      expect(minus1up2two.get_price).to eq (2000 + (10 * 1900))
    end
  end
end

describe 'Checkout' do
  let(:princing_rules_0) { { prices: {'VOUCHER' => 500, 'TSHIRT' => 2000, 'MUG' => 750}, reductions: {'VOUCHER' => nil, 'TSHIRT' => nil, 'MUG' => nil} } }
  let(:princing_rules_1) { { prices: {'VOUCHER' => 500, 'TSHIRT' => 2000, 'MUG' => 750}, reductions: {'VOUCHER' => :two4one, 'TSHIRT' => :minus1up22, 'MUG' => nil} } }

  describe "Checkout without reduction" do
    before :each do
      @checkout = Checkout.new princing_rules_0
      @checkout.scan 'VOUCHER'
      @checkout.scan 'TSHIRT'
      @checkout.scan 'VOUCHER'
      @checkout.scan 'VOUCHER'
      @checkout.scan 'MUG'
      @checkout.scan 'TSHIRT'
      @checkout.scan 'TSHIRT'
    end

    it { expect(@checkout.total_price).to eq (8250) }
  end

  describe "Checkout with reduction" do
    before :each do
      @checkout = Checkout.new princing_rules_1
      @checkout.scan 'VOUCHER'
      @checkout.scan 'TSHIRT'
      @checkout.scan 'VOUCHER'
      @checkout.scan 'VOUCHER'
      @checkout.scan 'MUG'
      @checkout.scan 'TSHIRT'
      @checkout.scan 'TSHIRT'
    end

    it { expect(@checkout.total_price).to eq (7550) }
  end

end
