class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  # checks if stock is already added by the user
  def stock_already_added?(ticker_symbol)
    # the method find_by_ticker, simply looks for the ticker_symbol in the table see if it exist there
    stock = Stock.find_by_ticker(ticker_symbol)
    # if its nil return false
    return false unless stock
    # if it does exist, look for association
    user_stocks.where(stock_id: stock.id).exists?
  end

  # simply track if user is under limit of 10
  def under_stock_limit?
    (user_stocks.count < 10)
  end

  def can_add_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end
end
