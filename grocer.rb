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

      cart[name][:count] = cart_count - amount_to_subtract
      cart["#{name} W/COUPON"] = {
        :price => coupon[:cost],
        :clearance => cart[name][:clearance],
        :count => 1
      }

    end
    cart
  }
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
