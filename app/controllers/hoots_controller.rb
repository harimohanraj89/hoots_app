class HootsController < ApplicationController

	def index
		@hoots = Hoot.order(created_at: :asc)
		render json: @hoots
	end

	def show
		@hoot = Hoot.find(params[:id])
		render json: @hoot
	end

	def create
		@hoot = Hoot.create(hoot_params)
		render json: @hoot
	end

	def update
		@hoot = Hoot.update(params[:id], hoot_params)
		render json: @hoot
	end

	def destroy
		@hoot = Hoot.destroy(params[:id])
		render json: @hoot
	end

	private

	def hoot_params
		params.require(:hoot).permit(:content, :author)
	end
end