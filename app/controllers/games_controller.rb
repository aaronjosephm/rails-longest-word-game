require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score

    @result = "sorry"
    attempt = params[:question]
    letters = params[:collected_input].split(" ")
    puts @letters
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    if JSON.parse(open(url).read)["found"] == true && grid_valid(attempt, letters) == true
      @result = "Well done"
    elsif grid_valid(attempt, letters) == false && JSON.parse(open(url).read)["found"] == true
      @result = "not in the grid"
    else
      @result = "Not an english word"
    end
  end

  def grid_valid(attempt, grid)
    result = attempt.upcase.split("").all? do |letter|
      grid.include?(letter)
      grid.delete(letter)
    end
    return result
  end
end
