class CoreController < ApplicationController

	skip_before_filter :authenticate_user!, :only => [:index, :convert_pdf]

	def index
	end

	def home
	end

	def admin
	end

	def convert_pdf
		
		if not params[:url].blank?
			if params[:url].starts_with? "https"
				require 'net/https'
				require 'uri'
				@url = URI.parse(URI.unescape(params[:url]))
				http = Net::HTTP.new(@url.host, @url.port)
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE
				request = Net::HTTP::Get.new(@url.request_uri)
				@res = http.request(request)
			else
				require 'net/http'
				require 'uri'
				@url = URI.parse(URI.unescape(params[:url]))
				@res = Net::HTTP.get_response(@url)
			end
			#render(:layout => false)
			render :pdf => "output.pdf"#, :wkhtmltopdf => "/usr/bin/wkhtmltopdf-i386", :temp_path => Rails.root.join('tmp')
		else
			render(:text => "You must pass a URL parameter")
		end
	end
end
