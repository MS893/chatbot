# gems
require 'dotenv'
require 'http'
require 'json'

# Ceci appelle le fichier .env (doit être situé dans le même dossier que celui d'où tu exécutes l'app.rb)
Dotenv.load('../.env')

# création de la clé d'api et indication de l'url utilisée.
api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

# un peu de json pour envoyer des informations directement à l'API
data = {
  "prompt" => "1 recette de cuisine aléatoire",
  "max_tokens" => 100,
  "temperature" => 0.5,
  "model" => "babbage-002"
}
# Le paramètre max_tokens est utilisé pour contrôler le nombre maximum de tokens que le modèle doit générer pour la réponse. En ajustant cette valeur, vous pouvez influencer la longueur et la qualité des réponses générées par le modèle.
# La température est un paramètre utilisé lors de la génération de texte avec les modèles de langage comme GPT-3. Elle contrôle le degré d'exploration et de créativité dans les réponses générées par le modèle. La température est un nombre réel positif, généralement compris entre 0 et 1.

# une partie un peu plus complexe :
# - cela permet d'envoyer les informations en json à ton url
# - puis de récupérer la réponse puis de séléctionner spécifiquement le texte rendu
response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body["choices"][0]["text"]

# ligne qui permet d'envoyer l'information sur ton terminal
puts "Hello, voici 1 recette de cuisine aléatoire :"
puts response_string
