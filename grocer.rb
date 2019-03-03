require "pry"

def get_label hash
  hash.keys.first
end

def consolidate_cart(cart)
  cart.reduce({}) {|totals, item|
    name = get_label(item)
    item[name][:count] ||= 0
    item[name][:count] = item[name][:count] + 1
    totals[name] = item[name]

    totals
  }
end

def apply_coupons(cart, coupons)
  coupons.reduce(cart) {|cart, coupon|
    name = coupon[:item]

    amount_to_subtract = cart[name][:count] >= coupon[:num] ? cart[name][:count] : coupon[:num]
    cart[name][:count] = cart[name][:count] - amount_to_subtract
    cart["#{name} W/COUPON"] = {
      :price => coupon[:cost],
      :clearance => cart[name][:clearance],
      :count => amount_to_subtract
    }

    cart
  }
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
