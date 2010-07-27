require File.dirname(__FILE__) + "/../test_helper"
require 'performance_test_help'

class HomepageTest < ActionController::PerformanceTest
  # Replace this with your real tests.
  def test_homepage
    get '/'
  end
end