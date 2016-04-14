require 'rails_helper'

RSpec.describe IntervieweesController, type: :controller do
	describe 'GET #index' do
		render_views
		it 'response success' do
			get :index
			expect(response).to be_success
		end
	end

	describe 'GET #new' do
		render_views
		it 'response success' do
			get :new
			expect(response).to be_success
		end

		it 'assigns interviewee' do
			get :new
			expect(assigns(:interviewee)).to be_a Interviewee
		end
	end

	let(:valid_params) {{
		name: 'Dennis',
		gender: 'male',
		number: '12345',
		position_id: 1
	}}

	let(:invalid_params) {{
		name: '',
		gender: '',
		number: ''
	}}

	describe 'POST #create' do
		render_views
		context 'create success' do
			before(:each) do
				post :create, interviewee: valid_params
			end

			it 'response redirect when success' do
				expect(response).to redirect_to edit_interviewee_path(assigns(:interviewee).to_param)
			end

			it 'create data' do
				interviewee = Interviewee.last
				expect(assigns(:interviewee)).to eq interviewee
				expect(assigns(:interviewee)).to be_persisted
			end
		end

		it 'render form when failed' do
			post :create, interviewee: invalid_params
			expect(response).to render_template :form
		end
	end

	let(:interviewee){ FactoryGirl.create :interviewee }

	describe 'GET #edit' do
		render_views
		before(:each) do
			get :edit, id: interviewee.to_param
		end
		it 'response success' do
			expect(response).to be_success
		end

		it 'assigns :interviewee' do
			expect(assigns(:interviewee)).to eq interviewee
		end
	end

	describe 'PUT #update' do
		render_views
		context 'update success' do
			before(:each) do
				put :update, id: interviewee.to_param, interviewee: valid_params
			end

			it 'redirect success' do
				expect(response).to redirect_to edit_interviewee_path interviewee.to_param
			end

			it 'update success' do
				expect(assigns(:interviewee).name).to eq valid_params[:name]
				expect(assigns(:interviewee).number).to eq valid_params[:number]
				expect(assigns(:interviewee).gender).to eq valid_params[:gender]
			end
		end
	end

	describe 'GET #calendar' do
		render_views
		it 'response success' do
			get :calendar, format: :xml
			expect(response).to be_success
		end
	end

	describe 'GET #result' do
		render_views
		let 'response success' do
			get :result
			expect(response).to be_success
		end
	end
end
