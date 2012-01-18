class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

module Ranglia

  class GMetric

    attr_accessor :config

    def initialize(config=nil, &block)
      config ||= Config.new
      self.config = config
      block.call(self.config) if block
    end

    def self.metrics
      @metrics ||= {}
    end

    def self.add_metric(name, options)

      default_options = {
              :name  => 'no_name',
              :group => 'no_group',
              :type  => 'int32',
              :units => 'count',
              :slope => 'both',
              :dmax  => 600
      }

      options.symbolize_keys!
      opts               = default_options.merge(options)
      self.metrics[name] = opts
    end

    def collect
      raise NotImplementedError
    end

    def run
      data = self.collect
      self.push(data)
    end

    protected
    def push(data)
      
      data.each do |name, value|
        metric_def = self.class.metrics[name]
        self.config.transport.push(metric_def, value)
      end

    end

  end

end