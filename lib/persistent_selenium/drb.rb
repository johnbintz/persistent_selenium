require 'drb'

module DRb
  class DRbTCPSocket
    alias :_set_sockopt :set_sockopt

    def set_sockopt(soc)
      _set_sockopt(soc)

      optval = [ PersistentSelenium.timeout, 0 ].pack("l_2")

      soc.setsockopt Socket::SOL_SOCKET, Socket::SO_RCVTIMEO, optval
      soc.setsockopt Socket::SOL_SOCKET, Socket::SO_SNDTIMEO, optval
    end
  end
end

