require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?                   # assert product is not valid
    assert product.errors[:title].any?        # assert product has error on title
    assert product.errors[:description].any?  # assert product has error on description
    assert product.errors[:price].any?        # assert product has error on price
    assert product.errors[:image_url].any?    # assert product has error on image_url
  end

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title', description: 'yyy', image_url: 'zzz.jpg')

      product.price = -1
      assert product.invalid?                 # assert product is not valid
      assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]                 # assert product has error on price

      product.price = 0
      assert product.invalid?                 # assert product is not valid
      assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]                # assert product has error on price

      product.price = 1
      assert product.valid?                   # assert product is valid

  end

  def new_product(image_url)
    Product.new(title: 'My Book Title', description: 'yyy', price: 1, image_url: image_url)
  end

  test 'image url' do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test 'product is not valid without a unique title' do
    product = Product.new(title: products(:ruby).title, description: 'yyy', price: 1, image_url: 'fred.gif')

    assert product.invalid?                   # assert product is not valid
    assert_equal ['has already been taken'], product.errors[:title]  # assert product has error on title
  end

  test 'product is not valid without a unique title - i18n' do
    product = Product.new(title: products(:ruby).title, description: 'yyy', price: 1, image_url: 'fred.gif')

    assert product.invalid?                   # assert product is not valid
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title] # compare error message with i18n and # assert product has error on title
  end

  test 'product title must be at least 10 characters long' do
    product = Product.new(title: 'fred', description: 'yyy', price: 1, image_url: 'fred.gif')

    assert product.invalid?                   # assert product is not valid
    assert_equal ['must be at least 10 characters long'], product.errors[:title]                  # assert product has error on title
  end
end
