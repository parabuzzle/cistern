include Socket::Constants
module AgentsHelper
  
  def get_commands(agent)
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in( agent.port, agent.hostname )
    socket.connect( sockaddr )
    h = Hash.new
    e = String.new
    payload = 'ls'
    authkey = Digest::MD5.hexdigest(agent.authkey + payload)
    h.store("authkey", authkey)
    h.store("payload", payload)
    h.each do |key, val|
      e = e + key.to_s + "__1_VV" + val.to_s + "__1_BB"
    end
    e = e + "__1_CC" + Digest::MD5.hexdigest(e) + "__1_EE"
    
    socket.write(e)
    r = socket.recvfrom(1045504)[0].chomp
    socket.close
    return break_commands(r)
  end
  
  def get_command(agent, command)
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in( agent.port, agent.hostname )
    socket.connect( sockaddr )
    h = Hash.new
    e = String.new
    payload = command
    authkey = Digest::MD5.hexdigest(agent.authkey + payload)
    h.store("authkey", authkey)
    h.store("payload", payload)
    h.each do |key, val|
      e = e + key.to_s + "__1_VV" + val.to_s + "__1_BB"
    end
    e = e + "__1_CC" + Digest::MD5.hexdigest(e) + "__1_EE"
    
    socket.write(e)
    r = socket.recvfrom(1045504)[0].chomp
    socket.close
    return r.gsub("\n", "<br/>")
  end
  
  def break_commands(r)
    a = r.split('/000/')
    return a
  end
  
end
