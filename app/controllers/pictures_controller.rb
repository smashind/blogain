class PicturesController < ApplicationController
  def destroy
  	@picture = Picture.find(params[:id])
  	@picture.destroy
  	respond_to do |format|
  	  format.html { redirect_to(:back) }
  	  format.json { head :no_content }
  	end
  end
end
