module CommandServer
  
  def check_sig(serverkey, payload)
    if serverkey != Digest::MD5.hexdigest("7952d3072b86a949e45232fe42ad03bc" + payload)
      return false
    else
      return true
    end
    return true
  end
  
  def command_list
    c = String.new
    AgentCommands.instance_methods.each do |command|
      c = c + command + "/000/"
    end
    return c
  end
  
  def get_command(data)
    #return data from cammand
    begin
      d = eval data
      return d
    rescue NameError
      return "not a valid command"
    end
  end
  
  def get_result(data)
    if data == "ls"
      return command_list
    else
      return get_command(data)
    end
  end
  
  def post_init
    puts "connection opened"
    #Log that the server connected
  end

  def receive_data data
    puts data
    (@buffer ||= BufferedTokenizer.new(delimiter = "__1_EE")).extract(data).each do |line|
      if line.valid?
        line = line.split('__1_CC')[0]
        parts = line.split('__1_BB')
        map = Hash.new
        parts.each do |part|
          p = part.split('__1_VV')
          map.store(p[0], p[1])
        end
        if check_sig(map['authkey'], map['payload'])
          puts map['payload']
          send_data get_result(map['payload'])
          puts get_result(map['payload'])
        else
          #log signature is bad
          puts "signature is bad - punted"
        end
      else
        #log checksum invalid
        puts "checksum is bad - punted"
      end
    end
  end

  def unbind
   #Log that the server disconnected
   puts "peer disconnected"
  end
end
 
class String
  def valid?
    part = self.split('__1_CC')
    #return true
    return Digest::MD5.hexdigest(part[0]) == part[1]
  end
end