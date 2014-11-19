require 'rails_helper'

describe SaveSection do
  subject { described_class.call(section, params) }

  let(:section) { double(Section, "attributes=" => true, save: true, "order=" => true, order: 1) }
  let(:params) { { title: 'title', item_id: 1, order: 1, image: 'image', order: 1 } }


  it "sets the attributes" do
    expect(section).to receive("attributes=").with(params)
    subject
  end

  it "returns the section when it is successful" do
    expect(section).to receive(:save).and_return(true)
    expect(subject).to be(section)
  end

  it "returns the false when it is unsuccessful" do
    expect(section).to receive(:save).and_return(false)
    expect(subject).to be(false)
  end

  it ""

end
