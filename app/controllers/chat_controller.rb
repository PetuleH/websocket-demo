class ChatController < ApplicationController
  include Tubesock::Hijack

  def chat
    #Rails.logger.debug "KWOK"
    hijack do |tubesock|
      # Listen on its own thread
      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "chat" do |on|
          on.message do |channel, message|
            Rails.logger.debug "KWOK #{message}"
            tubesock.send_data message 
          end
        end
      end

     # tubesock.onmessage do |m|
        # pub the message when we get one
        # note: this echoes through the sub above
      #  Rails.logger.debug "MESSAGE #{m}"
      #  Redis.new.publish "chat", m
      #end
      
      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
    end
  end

  def send_message
     hijack do |tubesock|
       tubesock.onmessage do |m|
        # pub the message when we get one
        # note: this echoes through the sub above
        #Rails.logger.debug "MESSAGE #{m}"
        Redis.new.publish "chat", m
      end

      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
     end
  end

end
