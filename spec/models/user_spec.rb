require 'rails_helper'
RSpec.describe User, :type => :model do

    
    describe 'Get multiple products availability' do
        it "takes a list of barcodes, radius, and location and returns applicable stores" do
            x = User.get_applicable_stores(["043765009345", "194721725820"],50000,"4200 Fifth Ave, Pittsburgh, PA 15260")
            expect(x.first()["name"]).to eq("Walmart")
        end
    end


end
 