require 'rails_helper'
RSpec.describe Company, :type => :model do


    describe 'location' do
        it "returns a hash of distances to all merchants from current user" do
            distances = Company.company_to_current_user_by_distance(nil)
            expect(distances).to be_an_instance_of(Hash)
        end
    end



    subject { described_class.new } # creates an ActiveRecord for Company with all nil fields
    it "is valid with valid attributes" do
        subject.name = "test"
        subject.description = "test description goes here"        
        subject.password = "sjkdfjksdhfsd"
        subject.username = "askfjsdjkfksjd"
        expect(subject).to be_valid
    end
    it "is not valid without a name" do
        subject.description = "test description goes here"
        expect(subject).to_not be_valid
    end
    it "is not valid without a description" do
        subject.name = "test"
        expect(subject).to_not be_valid
    end
end
 