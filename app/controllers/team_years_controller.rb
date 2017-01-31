class TeamYearsController < ApplicationController
  before_action :set_team_year, only: [:show, :edit, :update, :destroy]

  # GET /team_years
  # GET /team_years.json
  def index
    @team_years = TeamYear.all

    #
    ## Get TeamYears grouped by year
    #
    @year_groups = {}

    # get unique team_years
    @yrs = @team_years.map{|ty| ty.year }.uniq!
    # for each unique season
    @yrs.each{|yr|
      # create the array we'll feed the final hash
      @year_bucket = []
      # for each team_season in each year
      @team_years.where( year: yr).each{|row|
        @year_bucket << row.attributes
      }
      @year_groups[yr.to_sym] = @year_bucket.sort_by{|hsh| -hsh["wins"] }
    }


  end #index

  # GET /team_years/1
  # GET /team_years/1.json
  def show
  end

  # GET /team_years/new
  def new
    @team_year = TeamYear.new
  end

  # GET /team_years/1/edit
  def edit
  end

  # POST /team_years
  # POST /team_years.json
  def create
    @team_year = TeamYear.new(team_year_params)

    respond_to do |format|
      if @team_year.save
        format.html { redirect_to @team_year, notice: 'Team year was successfully created.' }
        format.json { render :show, status: :created, location: @team_year }
      else
        format.html { render :new }
        format.json { render json: @team_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_years/1
  # PATCH/PUT /team_years/1.json
  def update
    respond_to do |format|
      if @team_year.update(team_year_params)
        format.html { redirect_to @team_year, notice: 'Team year was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_year }
      else
        format.html { render :edit }
        format.json { render json: @team_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_years/1
  # DELETE /team_years/1.json
  def destroy
    @team_year.destroy
    respond_to do |format|
      format.html { redirect_to team_years_url, notice: 'Team year was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_year
      @team_year = TeamYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_year_params
      params.require(:team_year).permit(:year, :team, :wins, :losses, :win_percentage, :offensive_rating, :defensive_rating, :season_outcome, :team_url, :team_home_url)
    end
end
