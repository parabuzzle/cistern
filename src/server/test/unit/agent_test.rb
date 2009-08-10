require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "valid agent creation" do
    a = Agent.new
    a.name = "valid"
    a.hostname = "agent2.corp.cistern.com"
    a.port = "9845"
    a.authkey = "unused"
    assert a.save
  end
  
  #test "invalid agent creation - bad hostname" do
  #  a = Agent.new
  #  a.name = "valid"
  #  a.hostname = "agent2.corp.cistern"
  #  a.port = "9845"
  #  a.authkey = "unused"
  #  assert !a.save
  #end
  
  test "invalid agent creation - missing port" do
    a = Agent.new
    a.name = "valid"
    a.hostname = "agent3.corp.cistern.com"
    a.port = ""
    a.authkey = "unused"
    assert !a.save
  end
  
end
