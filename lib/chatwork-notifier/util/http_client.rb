# frozen_string_literal: true
require "net/http"

module Chatwork
  class Notifier
    class APIError < StandardError; end

    module Util
      class HTTPClient
        class << self
          def post uri, api_key, params
            HTTPClient.new(uri, api_key, params).call
          end
        end

        attr_reader :uri, :api_key, :params, :http_options

        def initialize uri, api_key, params
          @uri          = uri
          @api_key      = api_key
          @http_options = params.delete(:http_options) || {}
          @params       = params
        end

        def call
          http_obj.request(request_obj).tap do |response|
            unless response.is_a?(Net::HTTPSuccess)
              raise Chatwork::Notifier::APIError, <<-MSG
The Chatwork API returned an error: #{response.body} (HTTP Code #{response.code})
MSG
            end
          end
        end

        private

        def request_obj
          req = Net::HTTP::Post.new uri.request_uri
          req['X-ChatWorkToken'] = api_key
          req.set_form_data params[:payload]

          req
        end

        def http_obj
          http = Net::HTTP.new uri.host, uri.port
          http.use_ssl = (uri.scheme == "https")

          http_options.each do |opt, val|
            if http.respond_to? "#{opt}="
              http.send "#{opt}=", val
            else
              warn "Net::HTTP doesn't respond to `#{opt}=`, ignoring that option"
            end
          end

          http
        end
      end
    end
  end
end
