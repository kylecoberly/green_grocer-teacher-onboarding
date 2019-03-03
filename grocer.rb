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
  cart.map {|label, item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8 * 100).round / 100.0
    end
    [label, item]
  }.to_h
end

def find_cart_item(cart, name)
  match = cart.find {|label, item|
    label.eql? name
  }
  [match[0], match[1]].to_h
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  coupons = coupons.select {|coupon|
    found_item = find_cart_item(cart, coupon[:item])
    puts found_item.inspect
    found_item[:count] >= coupon[:num]
  }
  cart = apply_clearance(apply_coupons(cart, coupons))

  cart_total = cart.reduce(0.0) { |sum, (label, item)| sum += item[:price] * item[:count] }
  cart_total > 100 ? cart_total *= 0.9 : cart_total
end
