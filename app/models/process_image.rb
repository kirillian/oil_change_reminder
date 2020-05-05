class ProcessImage
	def initialize (image)
		@image = image
	end

	def process 
		@image.odometer_reading = odometer_reading
	end

	def response_text
		@response_text ||= google_api_response.parsed_response["responses"][0]["fullTextAnnotation"]["text"]
	end

	def miles_index
		@miles_index ||= response_text.index("miles")
	end

	def odometer_reading
		@odometer_reading ||= response_text[miles_index-7..miles_index-2] 
	end

	def url
		"https://vision.googleapis.com/v1/images:annotate?key=" + Rails.application.credentials.google_api_key
	end

	def body
		{ 
			requests: [
				{
					image: {
						source: {
							imageUri: @image.picture.service_url
						}
					},
					features: [
						{
							type: "TEXT_DETECTION"
						}
					]
				}
			]
		}
	end

	def google_api_response
		@google_api_response ||= HTTParty.post(url, headers: {"Content-Type" => "application/json; charset=UTF-8"}, body: body.to_json)
	end

end
