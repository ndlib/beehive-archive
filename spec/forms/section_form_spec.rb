require 'rails_helper'


describe SectionForm do
  let(:section) {double(Section)}
  subject { described_class.new(section)}

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
