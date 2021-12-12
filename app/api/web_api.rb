class WebApi
  def aceptar_cotizacion(_id_usuario, id_intencion)
    cotizacion_json = { id_intencion: id_intencion }.to_json
    put('/aceptar_cotizacion', cotizacion_json)
  end

  def obtener_publicaciones
    get('/publicaciones')
  end

  def consultar_intencion_de_venta(_id_usuario, id_intencion)
    get("/intenciones_de_venta/#{id_intencion}")
  end

  def obtener_publicacion(_id_usuario, id_publicacion)
    get("/publicaciones/#{id_publicacion}")
  end

  def ofertar_p2p(id_usuario, datos_oferta)
    oferta_json, id_publicacion = OfertaParser.new.a_json(datos_oferta, id_usuario)
    post("/publicaciones/#{id_publicacion}/ofertas", oferta_json)
  end

  def publicar_p2p(_id_usuario, datos_publicacion)
    pub_json = PublicacionParser.new.a_json(datos_publicacion)
    post('/publicaciones', pub_json)
  end

  def registrar_auto(id_usuario, datos_auto)
    auto_json = AutoParser.new.a_json(datos_auto)
    post("/usuarios/#{id_usuario}/intenciones_de_venta", auto_json)
  end

  def registrar_usuario(id_usuario, datos_usuario)
    usuario_json = UsuarioParser.new.a_json(datos_usuario, id_usuario)
    post('/usuarios', usuario_json)
  end

  def rechazar_oferta(_id_usuario, id_oferta)
    post("/ofertas/#{id_oferta}/rechazar", nil)
  end

  def aceptar_oferta(id_oferta)
    post("/ofertas/#{id_oferta}/aceptar", nil)
  end

  private

  def post(url_relativa, json_body)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.post(url, json_body, header)
    JSON.parse(response.body)
  end

  def put(url_relativa, json_body)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.put(url, json_body, header)
    JSON.parse(response.body)
  end

  def get(url_relativa)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.get(url, nil, header)
    JSON.parse(response.body)
  end

  def header
    { 'CONTENT_TYPE' => 'application/json',
      'BOT_TOKEN' => ENV['BOT_TOKEN'] }
  end
end
