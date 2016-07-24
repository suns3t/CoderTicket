require 'rails_helper'

RSpec.describe EventsController, type: :controller do

    describe "GET #index" do
        subject {get :index}
        it "renders the index template" do
            expect(subject).to render_template("events/index")
        end

        it "does not render a different template" do
            expect(subject).to_not render_template("events/show")
        end

    end
end
