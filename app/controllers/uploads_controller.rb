class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  def index
    @uploads = Upload.all
    respond_to do |format|
      format.html
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
    end
  end

  # GET /uploads/1
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.save
        format.html {
          render :json => [@upload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@upload.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update(upload_params)
        redirect_to @upload, notice: 'Upload was successfully updated.'
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
    def set_upload
      @upload = Upload.find(params[:id])
    end

    def upload_params
      params.require(:upload).permit(:upload_file_name, :upload_content_type, :upload_file_size, :upload_updated_at)
    end
end
