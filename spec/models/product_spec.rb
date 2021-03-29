require 'rails_helper'
RSpec.describe Product, :type => :model do

    
    describe 'search by company' do
        it "Searches for products by company" do
            products = Product.all
            products_1 = Product.where("company_id = 1")
            products = Product.search_by_companyid(products, 1, "")
            l = Array.new
            products.each do |x|
                l.append(x.pid)
            end
            products_1.each do |x|
                expect(l.include? x.pid).to be true
            end
        end
    end
    describe 'search' do
        it "Searches for products" do
            products1 = Product.all
            products = Product.search(products1, "")
            l = Array.new
            products1.each do |x|
                l.append(x.pid)
            end
            products.each do |x|
                expect(l.include? x.pid).to be true
            end
        end
    end

    describe 'location' do
        it "takes a list of products and returns distance to each" do
            products = Product.all
            Product.generate_distances(products, "4200 Fifth Ave, Pittsburgh, PA 15260")
            products.each do |p|
                expect(p.distance.nil?).to be false
            end
        end
    end

    
    describe 'location sort asc' do
        it "takes a list of products and returns distance to each sorted by dist asc" do
            products = Product.all
            Product.generate_distances(products, "4200 Fifth Ave, Pittsburgh, PA 15260")
            products = Product.order_by_dist(products, true)
            last = -1000
            products.each do |p|
                expect(p.distance).to be >= last
                last = p.distance
            end
        end
    end
    
    describe 'location sort desc' do
        it "takes a list of products and returns distance to each sorted by dist desc" do
            products = Product.all
            Product.generate_distances(products, "4200 Fifth Ave, Pittsburgh, PA 15260")
            products = Product.order_by_dist(products, false)
            last = 1000000000000
            products.each do |p|
                expect(p.distance).to be <= last
                last = p.distance
            end
        end
    end

    describe 'price sort desc' do
        it "takes a list of products and returns distance to each sorted by price desc" do
            products = Product.all
            products = Product.order_by_price(products, false)
            last = 1000000000000
            products.each do |p|
                expect(p.price).to be <= last
                last = p.price
            end
        end
    end

    describe 'price sort asc' do
        it "takes a list of products and returns distance to each sorted by price asc" do
            products = Product.all
            products = Product.order_by_price(products, true)
            last = -1000
            products.each do |p|
                expect(p.price).to be >= last
                last = p.price
            end
        end
    end

    describe 'price and dist sort desc' do
        it "takes a list of products and returns distance to each sorted by price and dist desc" do
            products = Product.all
            Product.generate_distances(products, "4200 Fifth Ave, Pittsburgh, PA 15260")
            products = Product.order_by_price_dist(products, false)
            last = 1000000000000
            last_p = 1000000000000
            products.each do |p|
                expect([p.distance <= last, p.price <= last_p]).to include(true)
                last = p.distance
                last_p = p.price
            end
        end
    end
    describe 'price and dist sort asc' do
        it "takes a list of products and returns distance to each sorted by price and dist asc" do
            products = Product.all
            Product.generate_distances(products, "4200 Fifth Ave, Pittsburgh, PA 15260")
            products = Product.order_by_price_dist(products, true)
            last = -1000
            last_p = -1000
            products.each do |p|
                expect([p.distance >= last, p.price >= last_p]).to include(true)
                last = p.distance
                last_p = p.price
            end
        end
    end

    subject { described_class.new } # creates an ActiveRecord for Story with all nil fields
    it "is valid with valid attributes" do
        subject.company_id = 5
        subject.description = "Great music"
        subject.name = "Swifter"
        subject.price = 5
        subject.image_url = "dfgs"
        subject.barcode = 55555
        expect(subject).to be_valid
    end    
    it "is not valid without company id" do
        subject.description = "Great music"
        subject.name = "Swifter"
        subject.price = 5
        expect(subject).to_not be_valid
    end
    it "is not valid without price" do
        subject.company_id = 5
        subject.description = "Great music"
        subject.name = "Swifter"
        expect(subject).to_not be_valid
    end
    it "is not valid without name" do
        subject.company_id = 5
        subject.description = "Great music"
        subject.price = 5
        expect(subject).to_not be_valid
    end
    it "is not valid without description" do
        subject.company_id = 5
        subject.price = 5
        subject.name = "Swifter"
        expect(subject).to_not be_valid
    end

end
 