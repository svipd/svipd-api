require 'rails_helper'
RSpec.describe User, :type => :model do

    
    describe 'Get multiple products availability' do
        it "takes a list of barcodes, radius, and location and returns applicable stores" do
            x = User.get_applicable_stores(["043765009345", "194721725820"],500,"4200 Fifth Ave, Pittsburgh, PA 15260")
            expect(x).to eq([{"name"=>"Walmart", "address"=>"2100 88th St, North Bergen, NJ 07047", "distance"=>312.81, "total"=>869.99}])
        end
    end


end
 