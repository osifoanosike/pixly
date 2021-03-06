class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like]

  # before_action :authenticate_user!, only: [:like]

  before_action :get_filter_category, only: [:index], if: "params[:filter]"

  # GET /photos
  # GET /photos.json
  def index
    @trending_photos = Photo.order(like_count: :desc).first(10)
    # @categories = Category.all

    if params[:filter]
      @photos = Photo.where(category_id: @current_category.id)
    elsif params[:page]
      @photos = Photo.offset(params[:page].to_i * 3).limit(3)
    else
      @photos = Photo.first(10)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    # @photo
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
    @photo.image_url  = upload_photo_and_return_name
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
    @like = Like.new(email: email, photo_id: params[:id])

    respond_to do |format|
      if @like.save
        format.js { @liked_photo = @photo }
        format.html { redirect_to root_url }
      else
        format.html { redirect_to root_url, notice: "You already liked this photo" }
        format.js { @already_liked = true, @liked_photo = @photo }
      end
    end   
  end

  def share
    share_info = {}
    share_info['email'] = params[:invitee_email]
    share_info['photo_path'] = photo_url(params[:photo])
    share_info["image_url"] = "#{request.base_url}/#{Photo.find(params[:photo]).image_url}"
    
    PhotoMailer.share(share_info).deliver_now
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def upload_photo_and_return_name
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
