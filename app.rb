require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


get("/") do

  ENV.fetch("EXCHANGE_RATES_KEY")
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch('EXCHANGE_RATES_KEY')}"

  
  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s


  parsed_data = JSON.parse(raw_data_string)

  
  @symbols = parsed_data["currencies"]


  erb(:homepage)
end

get("/:firstc") do
  ENV.fetch("EXCHANGE_RATES_KEY")
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch('EXCHANGE_RATES_KEY')}"

  
  raw_data = HTTP.get(api_url)

 
  raw_data_string = raw_data.to_s

 
  parsed_data = JSON.parse(raw_data_string)
  @symbols2 = parsed_data["currencies"]
  @firstcurr=params.fetch("firstc")
  erb(:conver)
end

get("/:firstc/:secondc") do
  
  @firstcurr=params.fetch("firstc")
  ENV.fetch("EXCHANGE_RATES_KEY")
  api_url = "https://api.exchangerate.host/live?access_key=#{ENV.fetch('EXCHANGE_RATES_KEY')}&source=#{@firstcurr}"


  raw_data = HTTP.get(api_url)


  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)
  @symbols2 = parsed_data["currencies"]
  @secondcurr=params.fetch("secondc")
  @pair=@firstcurr+@secondcurr
  @convalue = parsed_data["quotes"]
  @convalue2= @convalue[@pair]
  
  erb(:result)
end
