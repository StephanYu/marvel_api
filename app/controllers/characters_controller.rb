# class CharactersController < ApplicationController
#   before_action :set_character, only: [:show]

#   # GET /characters/1
#   def show
#     render json: @character
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_character
#       @character = Character.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def character_params
#       params.require(:character).permit(:name)
#     end
# end
