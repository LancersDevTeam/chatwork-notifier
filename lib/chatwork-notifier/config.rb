# frozen_string_literal: true
module Chatwork
  class Notifier
    class Config
      def initialize
        @http_client = Util::HTTPClient
        @defaults    = {}
      end

      def http_client
        return @http_client
      end

      def defaults new_defaults=nil
        return @defaults if new_defaults.nil?
        raise ArgumentError, "the defaults must be a Hash" unless new_defaults.is_a?(Hash)

        @defaults = new_defaults
      end
    end
  end
end
