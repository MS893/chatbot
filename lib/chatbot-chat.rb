# gems
require 'dotenv'
require 'http'
require 'json'

# Ceci appelle le fichier .env (doit être situé dans le même dossier que celui d'où tu exécutes l'app.rb)
Dotenv.load('../.env')
api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

loop do
  print "Vous : "
  question = gets.chomp
  break if question == "stop"
  data = {
    "prompt" => question,
    "max_tokens" => 10,
    "temperature" => 0.5,
    "model" => "babbage-002"  # autre model possible : davinci-002 ou gpt-3.5-turbo-instruct
  }
  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body["choices"][0]["text"]
  puts "IA : #{response_string}"
end
