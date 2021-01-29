module RailsLoggingFormatters
  class Configuration
    attr_accessor :formatter, :enabled, :transformer

    def initialize
      @enabled      = false
      @formatter    = Formatters::KeyValue
      @transformer  = Transformers::Default
    end
  end
end
