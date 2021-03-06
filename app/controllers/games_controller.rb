class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    gb = GiantBomb::Search.new("77dcb9ebcdb6c045950580d993599a609aaee78e")
    @game_json = gb.find_game(@game.name)
    
    @img_url = @game_json[0].image["icon_url"]
    @name = @game_json[0].name
    @rating = @game_json[0].original_game_rating
    @description = @game_json[0].deck
    #genres
      @genre0 = @game_json[0].genres[0].name

    @developers = @game_json[0].developers[0].name
    @publishers = @game_json[0].publishers[0].name
    
    @release_date = @game_json[0].original_release_date
    #Game Pictures
      @picture1 = @game_json[0].images[0]["screen_url"]
      @picture2 = @game_json[0].images[1]["screen_url"]
      @picture3 = @game_json[0].images[2]["screen_url"]
      @picture4 = @game_json[0].images[3]["screen_url"]
    

  end

  # GET /games/new
  def new
    @game = Game.new
    @micropost = current_user.microposts.build if signed_in?
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :picture)
    end
end
