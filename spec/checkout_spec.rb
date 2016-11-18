require 'spec_helper'
require_relative '../lib/checkout'

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
