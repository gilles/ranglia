module Ranglia

  class Config

    attr_writer :debug, :transport, :transport_opts

    def initialize(options={})

      default = {
              :debug => false,
              :transport => Ranglia::Transport::Cmd,
              :transport_opts => {}
      }
      opts = default.merge(options)

      self.debug = opts[:debug]
      self.transport = opts[:transport]
      self.transport_opts = opts[:transport_opts]

    end

    def debug(debug=nil)
      return @debug unless debug
      self.debug=debug
    end

    def transport(transport=nil)
      return @transport unless transport
      self.transport=transport
    end

    def transport_opts(options=nil)
      return @transport_opts unless options
      self.transport_opts=options
    end

  end

end