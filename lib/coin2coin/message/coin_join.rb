class Coin2Coin::Message::CoinJoin < Coin2Coin::Message::Base
  VERSION = 1
  
  property :version
  property :controller_instance
  
  def initialize
    self.version = VERSION
    self.controller_instance = Coin2Coin::Message::Association.new(true)
  end
end