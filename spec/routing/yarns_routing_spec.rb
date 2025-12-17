require "rails_helper"

RSpec.describe YarnsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/yarns").to route_to("yarns#index")
    end

    it "routes to #new" do
      expect(get: "/yarns/new").to route_to("yarns#new")
    end

    it "routes to #show" do
      expect(get: "/yarns/1").to route_to("yarns#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/yarns/1/edit").to route_to("yarns#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/yarns").to route_to("yarns#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/yarns/1").to route_to("yarns#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/yarns/1").to route_to("yarns#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/yarns/1").to route_to("yarns#destroy", id: "1")
    end
  end
end
