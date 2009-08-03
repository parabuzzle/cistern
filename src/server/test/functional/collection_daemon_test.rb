require 'test_helper'
require RAILS_ROOT + '/lib/modules/collection_server.rb'
include CollectionServer

class LogCollectorTest < ActionController::TestCase
  test "the truth" do
    assert true
  end
  
end