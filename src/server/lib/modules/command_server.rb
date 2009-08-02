module CommandServer
  def post_init
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    ActiveRecord::Base.logger.info "-- Command connection established from #{ip}"
  end

  def receive_data data
    # Do something with the log data
    ActiveRecord::Base.logger.info "#{data}"
  end

  def unbind
   ActiveRecord::Base.logger.info "-- Command connection closed by a peer"
  end
end