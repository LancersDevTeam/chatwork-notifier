# frozen_string_literal: true
require "uri"
require "json"

require_relative "chatwork-notifier/util/http_client"
require_relative "chatwork-notifier/util/link_formatter"
require_relative "chatwork-notifier/util/escape"
require_relative "chatwork-notifier/config"

module Chatwork
  class Notifier
    attr_reader :api_key, :room_id, :endpoint

    def initialize api_key, room_id, options={}, &block
      @api_key = api_key
      @room_id = room_id
      @endpoint = 'https://api.chatwork.com/v2'

      config.defaults options
      config.instance_exec(&block) if block_given?
    end

    def config
      @_config ||= Config.new
    end

    # post message to default room
    def ping message, options={}
      options[:body] = message
      url = URI.parse("#{endpoint}/rooms/#{room_id}/messages")

      post url, options
    end

    def post url, payload={}
      params  = {}
      client  = config.http_client
      payload = config.defaults.merge(payload)

      params[:http_options] = payload.delete(:http_options) if payload.key?(:http_options)
      params[:payload]      = payload

      client.post url, api_key, params
    end
  end
end
