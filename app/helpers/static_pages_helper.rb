module StaticPagesHelper
  def sandwiches(index)
    if index < 7 then
      return true
    else
      return false
    end
  end
end
