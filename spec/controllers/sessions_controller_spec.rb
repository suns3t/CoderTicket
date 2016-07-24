require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe "GET #new" do
        subject {get :new}
        it "render new template" do
            expect(subject).to render_template("sessions/new")
        end

        it "has a 200 status code" do
            expect(response.status).to eq(200)
        end
    end

    describe "POST #create" do
        subject {post :create}
        it "render create template" do
            expect(subject).to render_template("sessions/new")
        end
    end
end
