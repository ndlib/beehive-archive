require 'rails_helper'

describe CollectionRedirect do

  subject { described_class.call(1) }

  context "collection has an exhibit" do
    let(:exhibit) { double(Exhibit, id: 1) }

    it "redirects to the exhibit" do
      expect(Exhibit).to receive("find_by").with({collection_id: 1}).and_return(:exhibit)
      expect(subject).to eq("/exhibits/exhibit")
    end
  end

  context "collection does not have an exhibit" do
    it "redirects to new collection page with collection id set" do
      expect(Exhibit).to receive("find_by").with({collection_id: 1}).and_return(nil)
      expect(subject).to eq("/exhibits/new?collection_id=1")
    end
  end

end
