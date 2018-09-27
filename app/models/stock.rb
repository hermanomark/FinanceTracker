class Stock < ApplicationRecord
  
  def self.new_form_lookup(ticker_symbol)
    # catch the incorrect input 
    begin
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
      # strip last price with commas
      # price = strip_commas(looked_up_stock.close)
      # use .close for last price if it doesn't work use .l
      # use .name if .company_name doesn't work
      # you may wonder why we only have new insteaf of Stock.new because inside your Stock class you only need new keywork to create an object
      new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.close)
    rescue Exception => e
      return nil
    end
  end


  # as per checking the value are already float so we don't need to use this method
  # class level method so put the self
  # def self.strip_commas(number)
    # number should be a number without a comma
    # number.gsub(",","")
  # end
end
