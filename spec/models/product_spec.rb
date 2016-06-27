require "rails_helper"


RSpec.describe	Product, :type => :model do
  fixtures :products
  subject { Product.new(title: 'something', description: 'somethingelse', image_url: 'something.jpg')}

  it "should have a title, description, image_url, price" do
 	product = Product.new
 	expect(product).to be_invalid
  end

  it "should have an error for blank title" do
 	expect(Product.new).to have(1).error_on(:title)
  end

  it "should have an error for blank description" do
	expect(Product.new).to have(1).error_on(:description)
  end

  it "should have an error for blank image_url" do
	expect(Product.new).to have(1).error_on(:image_url)
  end

  it "should have an error for blank price" do
	expect(Product.new).to have(1).error_on(:price)
  end

  it "price must be positive" do
  	subject[:price] = -1
  	expect(subject).to have(1).error_on(:price)
  end

  it "price must be positive" do
  	subject[:price] = 0
  	expect(subject).to have(1).error_on(:price)
  end

  it "price must be positive" do
  	subject[:price] = 1
  	expect(subject).to have(0).error_on(:price)
  end

  it "image_url must be a gif/jpg/png" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    product = Product.new(title: 'something', description: 'somethingelse', price: '1')
    
      ok.each do |name|
        product[:image_url] = name
      end
      bad.each do |name|
        product[:image_url] = name
      end
  end

   it "title must be unique" do
    product = Product.new(title: products(:ruby).title, description: 'something', price:'1', image_url: 'something.jpg')
    expect(product).to be_invalid  
  end
end
