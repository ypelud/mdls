module ChoixmenuHelper

  def testcart(day, midisoir)
    day and session[:choix][day+midisoir] and session[:choix][day+midisoir].size > 0
  end
end
