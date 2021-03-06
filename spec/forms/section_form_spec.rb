require 'rails_helper'


describe SectionForm do
  let(:exhibit) { double(Exhibit, id: 1) }
  let(:showcase) { double(Showcase, id: 1, exhibit: exhibit, sections: sections) }
  let(:section) {double(Section, id: 1, order: 1, item_id: 1, showcase: showcase, "order=" => true, title: "the section") }
  let(:sections) { double( build: true )}

  subject { described_class.new(section)}

  describe "validation" do
    it "raises an error if order is blank" do
      section.stub(:order).and_return(nil)
      expect { subject }.to raise_error
    end
  end

  describe "#form_url" do
    it "returns an array with all the path objects" do
      expect(subject.form_url).to eq( [ exhibit, showcase, section ] )
    end
  end

  describe "#form_partial" do
    it "uses the section type class to determine type" do
      expect_any_instance_of(SectionType).to receive(:type).and_return('image')
      subject.form_partial
    end

    it "returns a the corect form for image sections" do
      subject.stub(:section_type).and_return("image")
      expect(subject.form_partial).to eq("image_form")
    end

    it "returns a the corect form for text sections" do
      subject.stub(:section_type).and_return("text")
      expect(subject.form_partial).to eq("text_form")
    end

    it "raises an error for an incorrect section" do
      subject.stub(:section_type).and_return("dsfasfasfasafafds")
      expect { subject.form_partial }.to raise_error
    end
  end


  describe "#title" do
    it "returns the title of the section" do
      expect(subject.title).to eq("the section")
    end
  end


  describe "build_from_params" do
    let(:controller) { double(ApplicationController, params: {} )}
    let(:new_params) { { exhibit_id: '10', showcase_id: '20', section: { order: '1'} } }
    let(:edit_params) { { exhibit_id: '10', showcase_id: '20', id: '30' } }
    subject { described_class.build_from_params(controller) }

    context "new_params" do
      before(:each) do
        allow(Showcase).to receive(:find).with('20').and_return(showcase)
        allow(sections).to receive(:build).and_return(section)

        controller.stub(:params).and_return(new_params)
      end

      it "finds the object from showcase" do
        expect(Showcase).to receive(:find).with('20').and_return(showcase)
        subject
      end

      it "builds the section from showcase" do
        expect(sections).to receive(:build).and_return(section)
        subject
      end

      it "sets the order " do
        expect(section).to receive("order=").with("1")
        subject
      end

      it "returns a new instance of SectionForm" do
        expect(subject).to be_a(SectionForm)
      end
    end

    context "edit_params" do
      before(:each) do
        allow(Section).to receive(:find).with('30').and_return(section)

        controller.stub(:params).and_return(edit_params)
      end

      it "finds the obect form the section" do
        expect(Section).to receive(:find).with('30').and_return(section)
        subject
      end

      it "returns a new instance of SectionForm" do
        expect(subject).to be_a(SectionForm)
      end
    end

  end

end
