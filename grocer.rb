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
    if cart[name]
      cart_count = cart[name][:count]
      coupon_count = coupon[:num]
      amount_to_subtract = cart_count >= coupon_count ? coupon_count : cart_count
      amount_to_increment = cart["#{name} W/COUPON"] ? cart["#{name} W/COUPON"][:count] + 1 : 1

      cart[name][:count] = cart_count - amount_to_subtract
      cart["#{name} W/COUPON"] = {
        :price => coupon[:cost],
        :clearance => cart[name][:clearance],
        :count => amount_to_increment
      }

    end
    cart
  }
end

def apply_clearance(cart)
  cart.map {|item|

  }
end

def checkout(cart, coupons)
  # code here
end
