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

  def registrar_usuario(id_usuario, datos_usuario)
    datos_json = UsuarioParser.new.a_json(datos_usuario, id_usuario)
    response = post2('/usuarios', datos_json)
    mensaje_de_respuesta2(response)
  end

  def rechazar_oferta(id_oferta)
    response = post2("/ofertas/#{id_oferta}/rechazar", nil)
    mensaje_de_respuesta2(response)
  end

  def aceptar_oferta(id_oferta)
    response = post2("/ofertas/#{id_oferta}/aceptar", nil)
    mensaje_de_respuesta2(response)
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

  def valor_de_respuesta_de_publicaciones
    JSON.parse(@response.body)
  end

  private

  # Este va a reemplazar al post()
  def post2(url_relativa, json_body)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.post(url, json_body,
                            'Content-Type' => 'application/json')
    response
  end

  def mensaje_de_respuesta2(response)
    JSON.parse(response.body)['mensaje']
  end
end
