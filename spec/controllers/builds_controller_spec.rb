require 'spec_helper'

describe BuildsController, type: :controller do
  describe "GET 'index'" do
    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

    context 'HTML view' do
      it "renders 'Listing builds'" do
        get :index
        expect(response.body) =~ /Listing builds/
      end
    end
  end

  describe "POST 'import'" do
    it 'redirects to root path' do
      post :import
      expect(response).to redirect_to '/'
    end

    it "renders 'Import failed' error" do
      post :import
      expect(response.body) =~ /Import failed/
    end

    it "renders 'Import finished successfully'" do
      allow(Importer).to receive(:import_csv_to_build).and_return(true)
      post :import
      expect(response.body) =~ /Import finished successfully/
    end
  end

  describe "DELETE 'destroy_all'" do
    it 'redirects to root path' do
      delete :destroy_all
      expect(response).to redirect_to '/'
    end

    it "renders 'All builds was destroyed'" do
      delete :destroy_all
      expect(response.body) =~ /All builds was destroyed/
    end

    it 'destroys all Build records' do
      create(:build)
      expect { delete :destroy_all }.to change { Build.count }.from(1).to(0)
    end
  end
end # describe BuildsController
