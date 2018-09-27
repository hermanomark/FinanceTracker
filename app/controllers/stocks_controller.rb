class StocksController < ApplicationController
  # def search
  #   if params[:stock].present?
  #     # returns the value of the ticker
  #     @stock = Stock.new_form_lookup(params[:stock])
  #     if @stock
  #       # this line of code renders the json in the view , ommited
  #       # render json: @stock
  #       # this line of code redicrects to users/my_portfolio, ommited
  #       # render 'users/my_portfolio'
      
  #       # ajax rails 5 way
  #       respond_to do |format|
  #         format.js { render partial: 'users/result' }
  #       end
        
  #     else
  #       # old code
  #       # flash[:danger] = "You have entered an incorrect symbol"
  #       # redirect_to my_portfolio_path
  #       # how to handle errors in rails 5 so it won't jumbled in view
  #       respond_to do |format|
  #         flash.now[:danger] = "You have entered an incorrect symbol "
  #         format.js { render partial: 'users/result' }
  #       end
  #     end 
  #   else
  #     respond_to do |format|
  #       flash.now[:danger] = "You have entered an empty search string "
  #       format.js { render partial: 'users/result' }
  #     end
  #   end
  # end

  # refractored code above
  def search
    if params[:stock].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @stock = Stock.new_form_lookup(params[:stock])
      flash.now[:danger] = "You have entered an incorrect symbol" unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
  
end
