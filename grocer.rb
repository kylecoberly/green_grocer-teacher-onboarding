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

def apply_coupons(cart, coupon)
  coupons.reduce(cart) {|cart, coupon|
    name = coupon[:item]
    binding.pry
    cart[name][:count] -= coupon[:count]
    cart["#{name} W/COUPON"] = cart[name]

    cart
  }
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
