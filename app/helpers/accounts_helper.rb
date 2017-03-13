module AccountsHelper
  
  def holders
    AccountHolder.all.pluck(:name)
  end

end
