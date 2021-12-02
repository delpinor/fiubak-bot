class WebApi
  def initialize(path)
    @url = ENV['API_HEROKU_URL'] + path
  end

  def post(datos_json)
    @response = Faraday.post(@url, datos_json,
                             'Content-Type' => 'application/json')
    self
  end

  def put(datos_json)
    @response = Faraday.put(@url, datos_json,
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

  def valor_de_respuesta_de_busqueda
    JSON.parse(@response.body)
  end
end
