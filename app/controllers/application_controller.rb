class ApplicationController < ActionController::API

  before_action :authenticate_request

  attr_reader :current_app

  #Include Serialization...
  include ActionController::Serialization

  #function to render pretter json
  def render_pretty_json(params)
    render json: JSON.pretty_generate(params.as_json)
  end

  private

  #Get mester by id
  def get_mester(id)
    Mester.find(id)
  end

   def authenticate_request
     @current_app = AuthorizeApiRequest.call(request.headers).result
     render json: { error: 'Not Authorized' }, status: 401 unless @current_app
   end

   #Time comarison function
  def get_day (date_time)
  	date_time.to_s[8...10]
  end

  def get_month (date_time)
  	date_time.to_s[5...7]
  end

  def get_year (date_time)

  	date_time.to_s[0...4]
  end

  def get_full_time(date_time)
  	date_time.to_s[11...-1]
  end

  def get_hour(date_time)
  	get_full_time(date_time).to_s[0...2]
  end

  def get_minutes(date_time)
  	get_full_time(date_time).to_s[3...5]
  end

  def get_seconds(date_time)
  	get_full_time(date_time).to_s[6..8]
  end


  def compare_dates(date_two)
  	#declae now as date_one
  	date_one = Time.now

  	#declare all the variables from year to monts to day to minutes and down to seconds

  	date_one_hour_int 	= get_hour(date_one).to_i
  	date_two_hour_int 	= get_hour(date_two).to_i
  	date_one_year_int  	= get_year(date_one).to_i
  	date_two_year_int  	= get_year(date_two).to_i
  	date_one_month_int 	= get_month(date_one).to_i
  	date_two_month_int 	= get_month(date_two).to_i
  	date_one_day_int  	= get_day(date_one).to_i
  	date_two_day_int  	= get_day(date_two).to_i
  	date_one_minute_int = get_minutes(date_one).to_i
  	date_two_minute_int = get_minutes(date_two).to_i
  	date_one_second_int = get_seconds(date_one).to_i
  	date_two_second_int = get_seconds(date_two).to_i

  	#Check same year
  	if date_one_year_int == date_two_year_int
  		#check for same month
  		if date_one_month_int == date_two_month_int
  			#same year same month
  			if date_one_day_int == date_two_day_int
  				#same date same month same day
  				if date_one_hour_int == date_two_hour_int
  					#same year same month same day same hour
  					#check whether same minute
  					if date_one_minute_int == date_two_minute_int
  						#same year, month, day, hour and minute
  						#Check for seconds
  						if date_one_second_int == date_two_second_int
  							#same everything
  							"now"
  						else
  							#same everything except seconds
  							difference = (date_one_second_int - date_two_second_int).to_s
  							"#{difference} seconds ago"
  						end
  					else
  						#different minute all else the same
  						difference = (date_one_minute_int - date_two_minute_int).to_s
  						"#{difference} minutes ago"
  					end
  				else
  					#Same year same month same day not the same hour
  					difference = (date_one_hour_int - date_two_hour_int).to_s
  					"#{difference} hours ago"
  				end
  			else
  				#same year same month but different day
  				difference = (date_one_day_int - date_two_day_int).to_s
  				"#{difference} days ago"

  			end
  		else
  			#Same year but different months
  			difference = (date_one_month_int - date_two_month_int).to_s
  			"#{difference} months ago"
  		end
  	else

  		#TODO: if the same year else statement
  		difference = (date_one_year_int - date_two_year_int).to_s
  		"#{difference} years ago"
  	end
  end

end
