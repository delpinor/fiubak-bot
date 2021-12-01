class WebApi
  def initialize(path)
    @url = ENV['API_HEROKU_URL'] + path
  end

  def post(datos_json)
    @response = Faraday.post(@url, datos_json,
                             'Content-Type' => 'application/json')
    self
  end

  def get
    @response = Faraday.get @url
    self
  end

  def id_de_respuesta
    JSON.parse(@response.body)['id']
  end

  def mensaje_de_respuesta
    JSON.parse(@response.body)['mensaje']
  end

  def valor_de_respuesta
    JSON.parse(@response.body)['valor']
  end
end
