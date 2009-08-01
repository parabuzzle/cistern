require 'test_helper'

class LogtypeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "new logtype" do
    l = Logtype.new
    l.name = "jboss"
    assert l.save
  end
  
  test "add logtype to an agent" do
    a = Agent.first
    l = Logtype.first
    l.add(a)
    a.reload
    c = a.logtypes.empty?
    if c != true
      assert true
    else
      assert false
    end
  end
    
  test "missing name" do
    l = Logtype.new
    assert !l.save
  end
   
end
