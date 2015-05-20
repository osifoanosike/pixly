class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like]

  # before_action :authenticate_user!, only: [:like]

  before_action :get_filter_category, only: [:index], if: "params[:filter]"

  # GET /photos
  # GET /photos.json
  def index
    @trending_photos = Photo.order(like_count: :desc).first(10)
    @categories = Category.all

    # if session[:friendly_redirect]
    #   redirect_to session[:friendly_redirect]
    #   session[:friendly_redirect] = nil
    # else
      if params[:filter]
        @photos = Photo.where(category_id: @current_category.id)
      else
        @photos = Photo.all
      end
      respond_to do |format|
        format.js
        format.html
      end
    # end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = current_user.photos.build(photo_params)
    @photo.image_url  = upload_photo_and_return_location
    respond_to do |format|
      if @photo.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
   
  end

  def like
    email = params[:user_email] ? params[:user_email] : current_user.email

    if @photo.user_already_liked?(email)
      respond_to do |format|
        format.html { redirect_to root_url, notice: "You already liked this photo" }
        format.js { @already_liked = true, @liked_photo = @photo }
      end
      logger.error "You liked this post previously"
    else
      @photo.like(email)
      respond_to do |format|
        if @photo.save
          format.js { @liked_photo = @photo }
          format.html { redirect_to root_url }
        else
          format.js { @liked_photo = @photo } #redirect_to root_url  notice: "photo couldn't be liked right now, please try again"
          logger.error "photo couldn't be liked right now, please try again"
        end
      end
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def upload_photo_and_return_location
      photo_img = photo_params[:image_url]
      File.open(Rails.root.join('app', 'assets', 'images', photo_img.original_filename), 'wb') do |file|
        file.write(photo_img.read)
      end

      return photo_img.original_filename
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :image_url, :like_count, :category_id)
    end

    def get_filter_category
      @current_category = Category.find_by(name: params[:filter])
    end
end
