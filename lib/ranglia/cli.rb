require 'optparse'

module Ranglia

  class CLI

    attr_accessor :argv

    def initialize(argv=ARGV)
      self.argv = argv
    end

    def parse()
      options = {}

      options[:debug]          = false
      options[:daemonize]      = false
      options[:sleep]          = 15
      options[:transport]      = Ranglia::Transport::Cmd
      options[:transport_opts] = {}

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: ranglia [options]"

        opts.on("-d", "--debug", "Debug") do |d|
          options[:debug] = d
        end

        opts.on("-X", "--daemonize", "Daemonize") do |d|
          options[:daemonize] = d
        end

        opts.on("-s", "--sleep [N]", "Sleep time in seconds") do |s|
          options[:sleep] = d
        end

        opts.on("-t", "--transport [TRANSPORT]", "Transport class") do |t|

          begin
            const = t.split('::').inject(Object) do |mod, class_name|
              mod.const_get(class_name)
            end
          rescue NameError
            puts "Invalid transport #{t}"
            exit
          end
          options[:transport] = const
        end

        opts.on("--transport-opts k1,v1,k2,v2", Array, "Transport options, will be transformed in Hash") do |o|
          h = Hash[*o]
          options[:transport_opts] = h
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts Ranglia::VERSION
          exit
        end

      end
      opts.parse!(argv)
      options
    end

    def run()
      options = self.parse

      shared_config = Ranglia::Config.new(options)
      p shared_config

      #daemonize

      #loop
      #read in a directory, load all *.rb
      #instanciate with shared config
      #run through the executor (sequential or threaded or fiber or forks)

    end


  end

end
