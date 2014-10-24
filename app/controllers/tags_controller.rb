class TagsController < ApplicationController
	def index
		@tags = Tag.all
	end

	def show
		@tag = Tag.find(params[:id])
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy
		respond_to do |format|
      		format.html { redirect_to tags_url }
      		format.json { head :no_content }
      	end
    end
end
