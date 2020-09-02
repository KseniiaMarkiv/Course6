require 'rails_helper'

RSpec.describe "ApiDevelopments", type: :request do
	def parsed_body
		JSON.parse(response.body)
	end

  describe "RDBMS-backed" do
  	before(:each) { City.delete_all }
  	after(:each) { City.delete_all }

  	it "create RDBMS-backed model" do
  		object=City.create(:name=>"Baltimore")
  		expect(City.find(object.id).name).to eq("Baltimore")
  end
  	it "expose RDBMS-backed API resource" do
			object=City.create(:name=>"Baltimore")
			expect(cities_path).to_eq("/api/cities") #- it's exceptions are dangerous to rescue as rescuing them
			get city_path(object.id)
			expect(response).to have_http_status(:ok)
  		expect(parsed_body["name"]).to eq("Baltimore")
  	end
  end

#   [133, 142] in C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/rspec-support-3.9.3/lib/rspec/support.rb
#    133:       # These exceptions are dangerous to rescue as rescuing them
#    134:       # would interfere with things we should not interfere with.
#    135:       AVOID_RESCUING = [NoMemoryError, SignalException, Interrupt, SystemExit]
#    136:
#    137:       def self.===(exception)
# => 138:         AVOID_RESCUING.none? { |ar| ar === exception }
#    139:       end
#    140:     end
#    141:
#    142:     # The Differ is only needed when a spec fails with a diffable failure.

  describe "MongoDB-backed" do
  	before(:each) { State.delete_all }
  	after(:each) { State.delete_all }

  	it "create MongoDB-backed model"do
  		object=State.create(:name=>"Maryland")
  		expect(State.find(object.id).name).to eq("Maryland")
  end
  	it "expose MongoDB-backed API resource"do
			object=State.create(:name=>"Maryland")
			expect(states_path).to_eq("/api/states") #- it's exceptions are dangerous to rescue as rescuing them
			get state_path(object.id)
			expect(response).to have_http_status(:ok)
  		expect(parsed_body["name"]).to eq("Maryland")
  		expect(parsed_body).to include("created_at")
  		expect(parsed_body).to include("id"=>object.id.to_s)
  		# binding.pry
  	end
  end
end
