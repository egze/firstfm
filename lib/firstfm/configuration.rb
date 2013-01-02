module Firstfm
  class Configuration
    attr_accessor :api_key

    DEFAULT_API_KEY = "REPLACE_WITH_REAL_KEY"

    def initialize
      @api_key = DEFAULT_API_KEY
    end

  end

  module Configurable
    def configure
      raise "Configuration missing" unless block_given?
      yield @config ||= Firstfm::Configuration.new
    end

    def config
      @config
    end
  end
  extend Configurable
end