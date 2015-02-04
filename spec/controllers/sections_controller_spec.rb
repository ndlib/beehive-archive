require "rails_helper"

RSpec.describe SectionsController, :type => :controller do
  let(:current_user) { double(User) }

  let(:exhibit) { double(Exhibit, id: 1, showcases: showcases) }
  let(:section) { double(Section, id: 1, "attributes=" => true, showcase: showcase, save: true, destroy: true, order: 1, "order=" => true) }
  let(:sections) { double(find: true, build: true, order: true )}
  let(:showcase) { double(Showcase, id: 1, sections: sections, exhibit: exhibit) }
  let(:showcases) { double(find: true)}


  before(:each) do
    sign_in(current_user)

    allow(Showcase).to receive(:find).and_return(showcase)
    allow(Section).to receive(:find).and_return(section)
    allow(Exhibit).to receive(:find).and_return(exhibit)
    allow(showcases).to receive(:find).and_return(showcase)
    allow(sections).to receive(:find).and_return(section)
    allow(sections).to receive(:build).and_return(section)
  end

  describe "index" do
    subject { get :index, exhibit_id: "1", showcase_id: "2" }

    it "sets the correct instance varible" do
      expect_any_instance_of(SectionQuery).to receive(:all_in_showcase).with(showcase).and_return([section])
      subject

      expect(assigns(:sections)).to be_a(ShowcaseList)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:index)
    end
  end

  describe "new" do
    subject { get :new, exhibit_id: 20, showcase_id: "10", section: { order: 1 } }


    it "sets the correct instance varible" do
      expect(SectionForm).to receive(:build_from_params)
      subject

      assigns(:section_form)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:new)
    end
  end

  describe "show" do
    subject { get :show, id: 10, exhibit_id: 20, showcase_id: "2" }

    it "sets the correct instance varible" do
      expect(sections).to receive(:find).with("10").and_return(section)

      subject

      expect(assigns(:exhibit)).to eq(exhibit)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:show)
    end

    it "returns a successful json request"
  end


  describe "create" do
    let(:save_params) { {title: 'title', image: "image"} }
    subject { put :create, section: save_params, exhibit_id: 20, showcase_id: 10 }

    it "sets the correct instance varible" do
      allow(SaveSection).to receive(:call).and_return(true)
      expect(sections).to receive(:build).and_return(section)

      subject

      expect(assigns(:section)).to eq(section)
    end

    it "creates the showcase" do
      expect(SaveSection).to receive(:call).and_return(true)
      subject
    end

    it "redirects on save success" do
      allow(SaveSection).to receive(:call).and_return(true)
      expect(subject).to redirect_to(exhibit_showcase_sections_path(section.showcase.id, section.showcase.exhibit.id))
    end

    it "renders the form on save error" do
      allow(SaveSection).to receive(:call).and_return(false)
      expect(subject).to render_template(:new)
    end
  end

  describe "edit" do
    subject { get :edit, id: 10, exhibit_id: 20, showcase_id: "30" }

    it "sets the correct instance varible" do
      expect(SectionForm).to receive(:build_from_params)

      subject

      assigns(:section_form)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:edit)
    end
  end


  describe "update" do
    let(:save_params) { {title: 'title'} }
    subject { post :update, id: "10", exhibit_id: 20, showcase_id: 10, section: save_params }

    it "sets the correct instance varible" do
      allow(SaveSection).to receive(:call).and_return(true)
      expect(sections).to receive(:find).with("10").and_return(section)

      subject

      expect(assigns(:section)).to eq(section)
    end

    it "updates the showcase" do
      expect(SaveSection).to receive(:call).and_return(true)
      subject
    end

    it "redirects on save success" do
      allow(SaveSection).to receive(:call).and_return(true)
      expect(subject).to redirect_to(exhibit_showcase_sections_path(showcase.exhibit.id, showcase.id))
    end

    it "renders the form on save error" do
      allow(SaveSection).to receive(:call).and_return(false)
      expect(subject).to render_template(:edit)
    end
  end

  describe "destroy" do
    subject { post :destroy, id: "10", exhibit_id: "20", showcase_id: "30" }

    it "sets the correct instance varible" do
      expect(sections).to receive(:find).with("10").and_return(section)

      subject

      expect(assigns(:section)).to eq(section)
    end

    it "redirects on destroy success" do
      allow(section).to receive(:destroy).and_return(true)
      expect(subject).to redirect_to(exhibit_showcase_sections_path(showcase.exhibit.id, showcase.id))
    end

  end

end
