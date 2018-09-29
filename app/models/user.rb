class User < ApplicationRecord
  # many to many association to users and stocks
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # many to many association to users and friends, note: table itself
  has_many :friendships
  has_many :friends, through: :friendships

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
  
  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    User.where("#{field_name} like ?", "%#{param}%")
  end

  # this is not class level method, we're going to run this on instance of the class, dont need the self here
  # prevent seeing yourself in search for friends
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  # use this now in _result.html.erb
  # prevent to add already friends
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end
end
