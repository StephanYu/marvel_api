require 'rails_helper'

RSpec.describe ComicsController, :type => :controller do

  describe "GET index" do
    it "assigns all comics as @comics" do
      comic = Comic.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:comics)).to eq([comic])
    end
  end

  describe "GET show" do
    it "assigns the requested comic as @comic" do
      comic = Comic.create! valid_attributes
      get :show, {:id => comic.to_param}, valid_session
      expect(assigns(:comic)).to eq(comic)
    end
  end

  describe "GET edit" do
    it "assigns the requested comic as @comic" do
      comic = Comic.create! valid_attributes
      get :edit, {:id => comic.to_param}, valid_session
      expect(assigns(:comic)).to eq(comic)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested comic" do
        comic = Comic.create! valid_attributes
        put :update, {:id => comic.to_param, :comic => new_attributes}, valid_session
        comic.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested comic as @comic" do
        comic = Comic.create! valid_attributes
        put :update, {:id => comic.to_param, :comic => valid_attributes}, valid_session
        expect(assigns(:comic)).to eq(comic)
      end

      it "redirects to the comic" do
        comic = Comic.create! valid_attributes
        put :update, {:id => comic.to_param, :comic => valid_attributes}, valid_session
        expect(response).to redirect_to(comic)
      end
    end

    describe "with invalid params" do
      it "assigns the comic as @comic" do
        comic = Comic.create! valid_attributes
        put :update, {:id => comic.to_param, :comic => invalid_attributes}, valid_session
        expect(assigns(:comic)).to eq(comic)
      end

      it "re-renders the 'edit' template" do
        comic = Comic.create! valid_attributes
        put :update, {:id => comic.to_param, :comic => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

end
