class StylesController < ApplicationController
  def most_popular
    @most_popular = Style.most_popular
  end

end
