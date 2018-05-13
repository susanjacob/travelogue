class PostsController < ApplicationController
  before_filter :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :ensure_ownership, only: [:update, :destroy]

  respond_to :html

  # GET /posts
  # List all the posts
  def index
    @posts = Post.all
    respond_with(@posts)
  end

  # GET /posts/:id
  # Show a particular post
  def show
    respond_with(@post)
  end

  # GET Initializes a new post
  # /posts/new
  def new
    @post = Post.new
    respond_with(@post)
  end

  # GET /posts/:id/edit
  # Edit an existing post
  def edit
    # Renders the edit form
  end

  # POST /posts
  # Creates a new post
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.save
    respond_with(@post)
  end

  # PUT /posts/:id
  # Updates given post
  def update
    @post.update_attributes(params[:post])
    respond_with(@post)
  end

  # DELETE /posts/:id
  # Deletes given post
  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
  # Retrieve the post object
  def set_post
    @post = Post.find(params[:id])
  end

  # Raise error if current_user is not the owner of the post
  def ensure_ownership
    raise StandardError, I18n.t('user.unauthorised', email: current_user.email) if @post.user != current_user
  end
end
