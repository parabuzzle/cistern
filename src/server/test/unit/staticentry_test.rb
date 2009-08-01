require 'test_helper'
require 'digest/md5'

class StaticentryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "new static entry" do
    s = Staticentry.new
    s.logtype_id = 1
    s.data = "new entry"
    assert s.save
  end
  
  #This test is broken... probably lack of understanding of fixtures... :(
  #test "duplicate key handling" do
  #  s = Staticentry.new
  #  s.id = "264e11eb5153fe6bff62a68a2e51d48c"
  #  s.logtype_id = 1
  #  s.data = "newest entry"
  #  s.save
  #  d = Staticentry.new
  #  d.id = "264e11eb5153fe6bff62a68a2e51d48c"
  #  d.logtype_id = 1
  #  d.data = "newest entry"
  #  d.save
  #  f = Staticentry.find("264e11eb5153fe6bff62a68a2e51d48c").count
  #  if f == 1 then assert true end
  #end
  
end
