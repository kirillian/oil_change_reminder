class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  #api call
  def call
    url = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyBszwJvsVsr7JtQcCEuglruK6dcONsDuHM"
    body = { 
      requests: [
        {
          image: {
            source: {
              imageUri: rails_blob_path(@image.picture)
            }
          },
          features: [
            {
              type: "TEXT_DETECTION"
            }
          ]
        }
      ]
    }
    #
    HTTParty.post(url, headers: {"Content-Type" => "application/json; charset=UTF-8"}, body: body.to_json)
  end

  # GET /images
  def index
    @images = Image.all
  end

  # GET /images/1
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  def create
    @image = Image.new(image_params)
    response = call
    binding.pry
    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      redirect_to @image, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
    redirect_to images_url, notice: 'Image was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:time_stamp, :odometer_reading, :oil_change, :picture)
    end
end
