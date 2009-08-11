module AgentCommands

  def ps_auxx
    return `ps auxx`
  end
  def top
    return `top -l 1`
  end
  
  def get_users
    return `w`
  end
  
  def say_foo
    return "foo!"
  end
  
end
