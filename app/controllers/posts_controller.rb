class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 3).published
  end

  def drafts
    @posts = Post.paginate(:page => params[:page], :per_page => 3).draft.where(user_id: current_user.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comment.post_id = @post.id
    @pictures = @post.pictures.to_a
  end

  # GET /posts/new
  def new
    @post = Post.new
    @picture = @post.pictures.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        if params[:pictures]
          params[:pictures]['imagename'].each do |a|
            @picture = @post.pictures.create!(:imagename => a, :image_id => @post.id)
          end
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        if params[:pictures]
          params[:pictures]['imagename'].each do |a|
            @picture = @post.pictures.create!(:imagename => a, :image_id => @post.id)
          end
        end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :tag_list, :body, :published, :user_id, pictures_attributes: [:id, :post_id, :imagename])
    end
end
