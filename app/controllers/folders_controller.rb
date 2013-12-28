class FoldersController < ApplicationController
	

	def new
		@folder = Folder.new								
	end

	def create
		@folder = Folder.new(folder_params)
  	@folder.save

  	respond_to do |format|
      if @folder.save #redirecting to root -- need to change to "add Folder"
        format.html { redirect_to folder_path(@folder), notice: 'Folder was successfully created.' }
        format.json { render action: '#', status: :created, location: @folder }
      else
        format.html { render action: 'new' }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
	end

  def show
    @folder = Folder.find(params[:id])
    @pins = @folder.pins.all
    @pin = Pin.new
  end

  def create_pin
    @folder = Folder.find(params[:id])
    @pin = @folder.pins.build(pin_params)
    if @pin.save
      render :action => :show
    end
    
    # @pin = Pin.new
    # @pins = @folder.pins.all
  end

	def folder_params
      # Never trust parameters from the scary internet, only allow the white list through.
      params.require(:folder).permit(:store_id, :season, :description)
  end

  def pin_params
      # Never trust parameters from the scary internet, only allow the white list through.
      params.require(:pin).permit(:description, :image, :folder_id)
    end
end