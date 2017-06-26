Send message to Chatwork.

# Example
require 'chatwork-notifier'

notifier = Chatwork::Notifier.new('chatwork_api_key', 'room_id')
notifier.ping('message')
