require 'rails_helper'

RSpec.describe Section do

  [:title, :description, :image, :item_id, :order, :caption, :showcase, :display_type].each do |field|
    it "has the field #{field}" do
      expect(subject).to respond_to(field)
      expect(subject).to respond_to("#{field}=")
    end
  end

  [:item_id, :image, :showcase].each do | field |
    it "requires the field, #{field}" do
      expect(subject).to have(1).error_on(field)
    end
  end

  it "validates display_type to allow image " do
    subject.display_type = 'image'
    expect(subject).to have(0).errors_on(:display_type)
  end

  it "validates display_type to allow text " do
    subject.display_type = 'text'
    expect(subject).to have(0).errors_on(:display_type)
  end

  it "error display_type on other than text/image " do
    subject.display_type = '2324324'
    expect(subject).to have(1).errors_on(:display_type)
  end

end
