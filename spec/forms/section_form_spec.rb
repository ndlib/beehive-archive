require 'rails_helper'


describe SectionForm do
  let(:exhibit) { double(Exhibit, id: 1) }
  let(:showcase) { double(Showcase, id: 1, exhibit: exhibit) }
  let(:section) {double(Section, id: 1, showcase: showcase, order: 1, display_type: 'image') }

  subject { described_class.new(section)}

  describe "validation" do
    it "raises an error if order is blank" do
      section.stub(:order).and_return(nil)
      expect { subject }.to raise_error
    end

    it "raises an error if display_type is blank" do
      section.stub(:display_type).and_return(nil)
      expect { subject }.to raise_error
    end
  end

  describe "#form_url" do
    it "returns an array with all the path objects" do
      expect(subject.form_url).to eq( [ exhibit, showcase, section ] )
    end
  end

  describe "#form_partial" do

    it "returns a the corect form for image sections" do
      section.stub(:display_type).and_return("image")
      expect(subject.form_partial).to eq("image_form")
    end

    it "returns a the corect form for text sections" do
      section.stub(:display_type).and_return("text")
      expect(subject.form_partial).to eq("text_form")
    end

    it "raises an error for an incorrect section" do
      section.stub(:display_type).and_return("dsfasfasfasafafds")
      expect { subject.form_partial }.to raise_error
    end
  end

end
