module Ranglia
  module Transport

    class Cmd

      attr_accessor :bin, :config, :group, :debug

      def initialize(options={})

        default = {
                :bin => '/usr/bin/gmetric',
                :config => '/etc/ganglia/gmond.conf',
                :group => false,
                :debug => false
        }
        opts = default.merge(options)

        self.bin = opts[:bin]
        self.config = opts[:config]
        self.group = opts[:group]
        self.debug= opts[:debug]
      end

      def push(metric_def, value)
        cmd = gmetric_cmd(metric_def, value)
        if self.debug
          STDOUT.puts cmd
        else
          Kernel.system(cmd)
        end
      end

      def gmetric_cmd(metric_def, value)

        cmd = ["#{self.bin}", "-c", "#{self.config}"]
        if self.group
          cmd << "--group=#{metric_def[:group]}" << "--name=#{metric_def[:name]}"
        else
          cmd << "--name=#{metric_def[:group]}_#{metric_def[:name]}"
        end
        [:type, :units, :slope, :dmax].each do |p|
          cmd << "--#{p}=#{metric_def[p]}"
        end
        cmd << "--value=#{value}"
        cmd.join(' ')
      end

    end

  end
end