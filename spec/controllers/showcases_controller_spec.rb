require "rails_helper"

RSpec.describe ShowcasesController, :type => :controller do
  let(:current_user) { double(User) }
  let(:exhibit) { double(Exhibit, showcases: showcases)}
  let(:showcases) { double(find: true, build: true )}
  let(:showcase) { double(Showcase, save: true, update_attributes: true, destroy: true, exhibit: exhibit) }

  before(:each) do
    sign_in(current_user)

    allow(Exhibit).to receive(:find).and_return(exhibit)
    allow(showcases).to receive(:find).and_return(showcase)
    allow(showcases).to receive(:build).and_return(showcase)
  end

  describe "index" do
    subject { get :index, exhibit_id: 20 }

    it "sets the correct instance varible" do
      expect(exhibit).to receive(:showcases).and_return([showcase])
      subject

      expect(assigns(:showcases)).to eq([showcase])
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:index)
    end
  end


  describe "new" do
    subject { get :new, exhibit_id: 20 }


    it "sets the correct instance varible" do
      subject

      expect(assigns(:showcase)).to eq(showcase)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:new)
    end
  end


  describe "show" do
    subject { get :show, id: 10, exhibit_id: 20 }

    it "sets the correct instance varible" do
      expect(showcases).to receive(:find).with("10").and_return(showcase)

      subject

      expect(assigns(:showcase)).to eq(showcase)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:show)
    end
  end


  describe "create" do
    let(:save_params) { {title: 'title'} }
    subject { put :create, showcase: save_params, exhibit_id: 20 }

    it "sets the correct instance varible" do
      expect(showcases).to receive(:build).with(save_params).and_return(showcase)

      subject

      expect(assigns(:showcase)).to eq(showcase)
    end

    it "creates the showcase" do
      expect(showcase).to receive(:save).and_return(true)
      subject
    end

    it "redirects on save success" do
      allow(showcase).to receive(:save).and_return(true)
      expect(subject).to redirect_to(exhibit_showcases_path(showcase.exhibit))
    end

    it "renders the form on save error" do
      allow(showcase).to receive(:save).and_return(false)
      expect(subject).to render_template(:new)
    end
  end


  describe "edit" do
    subject { get :edit, id: 10, exhibit_id: 20 }

    it "sets the correct instance varible" do
      expect(showcases).to receive(:find).with("10").and_return(showcase)

      subject

      expect(assigns(:showcase)).to eq(showcase)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:edit)
    end
  end


  describe "update" do
    let(:save_params) { {title: 'title'} }
    subject { post :update, id: "10", exhibit_id: "20", showcase: save_params }

    it "sets the correct instance varible" do
      expect(showcases).to receive(:find).with("10").and_return(showcase)

      subject

      expect(assigns(:showcase)).to eq(showcase)
    end

    it "updates the showcase" do
      expect(showcase).to receive(:update_attributes).with(save_params).and_return(true)
      subject
    end

    it "redirects on save success" do
      allow(showcase).to receive(:update_attributes).and_return(true)
      expect(subject).to redirect_to(exhibit_showcases_path(showcase.exhibit))
    end

    it "renders the form on save error" do
      allow(showcase).to receive(:update_attributes).and_return(false)
      expect(subject).to render_template(:edit)
    end
  end


  describe "destroy" do
    subject { post :destroy, id: "10", exhibit_id: "20" }

    before(:each) do
      allow(Exhibit).to receive(:find).and_return(exhibit)
    end

    it "sets the correct instance varible" do
      expect(showcases).to receive(:find).with("10").and_return(showcase)

      subject

      expect(assigns(:showcase)).to eq(showcase)
    end

    it "redirects on destroy success" do
      allow(showcase).to receive(:destroy).and_return(true)
      expect(subject).to redirect_to(exhibit_showcases_path(showcase.exhibit))
    end

  end

end


