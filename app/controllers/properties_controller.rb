class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy ]
  before_action :set_nearest_stations, only: [:show, :edit, :update]

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
    2.times { @property.nearest_stations.build }
  end

  def edit
    @property.nearest_stations.build
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to properties_path
    else
      2.times { @property.nearest_stations.build }
      render :new
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_property
      @property = Property.find(params[:id])
    end

    def set_nearest_stations
      @nearest_stations = @property.nearest_stations
    end

    def property_params
      params.require(:property).permit(
        :property_name,
        :rent,
        :address,
        :age,
        :note,
        nearest_stations_attributes: {}#: [:route_name, :station_name, :time]
      )
    end
end
