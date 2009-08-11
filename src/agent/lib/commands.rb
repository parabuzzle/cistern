module AgentCommands

  def ps_auxx
    return `ps auxx`
  end
  
  def get_users
    return `w`
  end
  
end