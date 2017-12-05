module ChatfuelHelper

	def CreateBroadcastURL(senderId, blockName, userAttributes)
		broadcastURL = ENV['CHATFUEL_BROADCAST_API']
		broadcastURL = broadcastURL.gsub('{CHATFUEL_BOT_ID}', ENV['CHATFUEL_BOT_ID'])
		broadcastURL = broadcastURL.gsub('{TOKEN}', ENV['CHATFUEL_TOKEN'])
		broadcastURL = broadcastURL.gsub('{SENDER_ID}', senderId)
		broadcastURL = broadcastURL.gsub('{BLOCK_NAME}', blockName)

		userAttributes.each do |ua|
			puts ua
			broadcastURL = "#{broadcastURL}&#{ua[0]}='#{ua[1]}'"
		end

		return broadcastURL
	end

	def SendMessageToIndividual(receiverSourceID, blockName, userAttributes)
		require 'net/http'
		require 'uri'

		blockName = "ReceiveHelperOffer"
		broadcastURL = CreateBroadcastURL(receiverSourceID, blockName, userAttributes)
		puts broadcastURL
		uri = URI.parse(broadcastURL)
		request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			begin
				http.request(request)
				puts "request made"
			rescue => e
				puts e
			end
		end
		puts response
		# if response.message == 'OK'
		# 	puts "Message sent succesfully"
		# 	#Message sent succesfully
		# end
	end

	
end
