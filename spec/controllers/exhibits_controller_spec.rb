require "rails_helper"

RSpec.describe ExhibitsController, :type => :controller do
  let(:current_user) { double(User) }
  let(:exhibit) { double(Exhibit, save: true, update_attributes: true, destroy: true) }

  before(:each) do
    sign_in(current_user)
  end

  describe "index" do
    subject { get :index }

    it "sets the correct instance varible" do
      expect_any_instance_of(ExhibitQuery).to receive(:all_for_user).with(current_user).and_return([exhibit])
      subject

      expect(assigns(:exhibits)).to eq([exhibit])
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:index)
    end
  end


  describe "new" do
    subject { get :new }

    it "sets the correct instance varible" do
      subject

      expect(assigns(:exhibit)).to be_a_new(Exhibit)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:new)
    end
  end


  describe "show" do
    subject { get :show, id: 10 }

    before(:each) do
      allow(Exhibit).to receive(:find).and_return(exhibit)
    end

    it "sets the correct instance varible" do
      expect(Exhibit).to receive(:find).with("10").and_return(exhibit)

      subject

      expect(assigns(:exhibit)).to eq(exhibit)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:show)
    end
  end


  describe "create" do
    let(:save_params) { {title: 'title'} }
    subject { put :create, exhibit: save_params }

    before(:each) do
      allow(Exhibit).to receive(:new).and_return(exhibit)
    end

    it "sets the correct instance varible" do
      expect(Exhibit).to receive(:new).with(save_params).and_return(exhibit)

      subject

      expect(assigns(:exhibit)).to eq(exhibit)
    end

    it "creates the exhibit" do
      expect(exhibit).to receive(:save).and_return(true)
      subject
    end

    it "redirects on save success" do
      allow(exhibit).to receive(:save).and_return(true)
      expect(subject).to redirect_to(exhibits_path)
    end

    it "renders the form on save error" do
      allow(exhibit).to receive(:save).and_return(false)
      expect(subject).to render_template(:new)
    end
  end


  describe "edit" do
    subject { get :edit, id: 10 }

    before(:each) do
      allow(Exhibit).to receive(:find).and_return(exhibit)
    end

    it "sets the correct instance varible" do
      expect(Exhibit).to receive(:find).with("10").and_return(exhibit)

      subject

      expect(assigns(:exhibit)).to eq(exhibit)
    end

    it "returns success for html request" do
      expect(subject).to be_success
      expect(subject).to render_template(:edit)
    end
  end


  describe "update" do
    let(:save_params) { {title: 'title'} }
    subject { post :update, id: "10", exhibit: save_params }

    before(:each) do
      allow(Exhibit).to receive(:find).and_return(exhibit)
    end

    it "sets the correct instance varible" do
      expect(Exhibit).to receive(:find).with("10").and_return(exhibit)

      subject

      expect(assigns(:exhibit)).to eq(exhibit)
    end

    it "updates the exhibit" do
      expect(exhibit).to receive(:update_attributes).with(save_params).and_return(true)
      subject
    end

    it "redirects on save success" do
      allow(exhibit).to receive(:update_attributes).and_return(true)
      expect(subject).to redirect_to(exhibits_path)
    end

    it "renders the form on save error" do
      allow(exhibit).to receive(:update_attributes).and_return(false)
      expect(subject).to render_template(:edit)
    end
  end


  describe "destroy" do
    subject { post :destroy, id: "10" }

    before(:each) do
      allow(Exhibit).to receive(:find).and_return(exhibit)
    end

    it "sets the correct instance varible" do
      expect(Exhibit).to receive(:find).with("10").and_return(exhibit)

      subject

      expect(assigns(:exhibit)).to eq(exhibit)
    end

    it "redirects on destroy success" do
      allow(exhibit).to receive(:destroy).and_return(true)
      expect(subject).to redirect_to(exhibits_path)
    end

  end

end


