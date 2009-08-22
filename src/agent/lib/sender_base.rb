module LogHelper
  def send_event(entry, authkey, logtype_id, agent_id)
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
    begin
      if @socket == false
        raise Errno::EPIPE
      end
      @socket.write(e)
    rescue Errno::EPIPE
      puts "server is not responding, dropping event"
      @socket = initialize_socket(@serverport, @serverhost)
    end
  end
  
  def initialize_socket(port, host, timeout=1)
    begin
      Timeout::timeout(timeout) do
        begin
          socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
          sockaddr = Socket.pack_sockaddr_in( port, host )
          socket.connect( sockaddr )
          return socket
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          puts "Server connection refused or unreachable"
          return false
        end
      end
    rescue Timeout::Error
      puts "server connection timeout"
    end
  end
end
