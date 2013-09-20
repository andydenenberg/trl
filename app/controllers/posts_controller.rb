class PostsController < ApplicationController
  before_filter :authenticate_user!
 
  def add_comment
    @post = Post.find(params[:post])
    @post.comments.new
    render :partial => 'add_comment', :layout => false    
  end

  def add_attachment
    @post = Post.find(params[:post])
    @post.attachments.new
    render :partial => 'add_attachments', :layout => false    
  end
    
  def index
    @categories = [ 'ALL CATEGORIES', '100 SERIES - GENERAL', '200 SERIES - APPLICATION & INSTALLATION',
                    '300 SERIES - TESTING', '400 SERIES - CERTFICATIONS & APPROVALS',
                    '500 SERIES - PRODUCT COMPARISONS', '600 SERIES - ARTICLES & WHITE PAPERS' ]  
    @products = [ 'ALL PRODUCTS', 'GENERAL - ALL PRODUCTS', 'AQUADRAIN', 'AKWASWELL', 'COREFLEX', 'ENVIROSHEET', 'LDC 60',
                  'STRATASEAL HR', 'ULTRASEAL', 'VOLTEX DS', 'WATERSTOP RX' ]
      
    @type_is = params[:type_is] # global variable required to setup the view
       
    @posts = Post.select_type(@type_is)
                 .select_category(params[:category])
                 .select_product(params[:product])
                 .search(params[:search_criteria])
                 .paginate(:page => params[:page], :per_page => 500).order('title asc')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @type_is = params[:type_is]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @type_is = params[:type_is]
    @post = Post.new
    @post.attachments.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @type_is = params[:type_is]
    
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
