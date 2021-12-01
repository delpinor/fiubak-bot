class WebApi
  def initialize(path)
    @url = ENV['API_HEROKU_URL'] + path
  end

  def post(datos_json)
    @response = Faraday.post(@url, datos_json,
                             'Content-Type' => 'application/json')
    mensaje_de_respuesta!
  end

  def get
    @response = Faraday.get @url
    valor_de_respuesta
  end

  private

  def mensaje_de_respuesta!
    JSON.parse(@response.body)['mensaje']
  end

  def valor_de_respuesta
    data_json = JSON.parse(@response.body)
    estado = data_json['valor']['estado']
    id = data_json['valor']['id']
    "la intencion de venta #{id} se encuentra: #{estado}"
  end
end
