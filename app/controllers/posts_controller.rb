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
    @categories = [ 'All Categories',
                    '100 SERIES - GENERAL', '200 SERIES - APPLICATION & INSTALLATION',
                    '300 SERIES - TESTING', '400 SERIES - CERTFICATIONS & APPROVALS',
                    '500 SERIES - PRODUCT COMPARISONS', '600 SERIES - ARTICLES & WHITE PAPERS' ]    
    @type_is = params[:type_is]
    category = params[:category] ||= 'All Categories'
    search_criteria = params[:search_criteria]
    
    if params[:type_is] == 'Glossary & Documents' or params[:type_is] == nil
      @posts = Post.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    elsif params[:type_is] == 'Documents'
      if params[:category] == 'All Categories'
        @posts = Post.where(:type_is => params[:type_is])    
      else
        @posts = Post.where(:type_is => params[:type_is]).where('category = ?', category)    
      end
      if search_criteria
         # postgres on Heroku is case sensitive so need to specify consistent lower case for wildcard search
        @posts = @posts.where('lower(body) LIKE ?', "%#{search_criteria.downcase}%" )
      end
      @posts = @posts.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
      
    else # Glossary
      @posts = Post.where(:type_is => params[:type_is]).paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    end

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
