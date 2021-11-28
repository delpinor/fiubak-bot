class UsuariosApi
  def initialize(path)
    @url = ENV['API_HEROKU_URL'] + path
  end

  def post(datos_json)
    @response = Faraday.post(@url, datos_json,
                             'Content-Type' => 'application/json')
    mensaje!
  end

  def mensaje!
    JSON.parse(@response.body)['mensaje']
  end
end
