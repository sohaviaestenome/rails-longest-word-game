require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    res = URI.open(url)
    resposta = res.read
    @response = JSON.parse(resposta)

    if @response["found"] == false
      @result = "Sorry but #{@word} is not an english word"
    elsif @response.key?("error")
      @result = "Sorry but #{@word} cannot be built out of #{@letters.join(',')}"
    else
      @result = "Congratulations #{@word} is valid!"
    end
  end
end
