module LogHelper
  def send_event(entry, socket, authkey, logtype_id, agent_id)
    event = Hash.new
    e = String.new
    entry = entry.chomp  
    puts entry
    event.store("authkey", authkey)
    event.store("logtype_id", logtype_id)
    event.store("agent_id", agent_id)
    event.store("loglevel_id", get_loglevel_id(entry))
    event.store("etime", get_time(entry))
    event.store("data", get_static(entry))
    event.store("payload", get_payload(entry))
    event.each do |key, val|
      e = e + key.to_s + '__1_VV' + val.to_s + '__1_BB'
    end
    e = e + '__1_CC' + Digest::MD5.hexdigest(e) + '__1_EE'
    socket.write(e)
  end
end
