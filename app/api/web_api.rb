class WebApi
  def aceptar_cotizacion(id_usuario, id_intencion)
    cotizacion_json = { id_intencion: id_intencion }.to_json
    put('/aceptar_cotizacion', cotizacion_json, id_usuario)
  end

  def obtener_publicaciones
    get('/publicaciones', 0)
  end

  def consultar_intencion_de_venta(id_usuario, id_intencion)
    get("/intenciones_de_venta/#{id_intencion}", id_usuario)
  end

  def obtener_publicacion(id_usuario, id_publicacion)
    get("/publicaciones/#{id_publicacion}", id_usuario)
  end

  def ofertar_p2p(id_usuario, datos_oferta)
    oferta_json, id_publicacion = OfertaParser.new.a_json(datos_oferta, id_usuario)
    post("/publicaciones/#{id_publicacion}/ofertas", oferta_json, id_usuario)
  end

  def solicitar_test_drive(id_usuario, id_publicacion)
    post("/publicaciones/#{id_publicacion}/test_drives", nil, id_usuario)
  end

  def publicar_p2p(id_usuario, datos_publicacion)
    pub_json = PublicacionParser.new.a_json(datos_publicacion)
    post('/publicaciones', pub_json, id_usuario)
  end

  def registrar_auto(id_usuario, datos_auto)
    auto_json = AutoParser.new.a_json(datos_auto)
    post("/usuarios/#{id_usuario}/intenciones_de_venta", auto_json, id_usuario)
  end

  def registrar_usuario(id_usuario, datos_usuario)
    usuario_json = UsuarioParser.new.a_json(datos_usuario, id_usuario)
    post('/usuarios', usuario_json, id_usuario)
  end

  def rechazar_oferta(id_usuario, id_oferta)
    post("/ofertas/#{id_oferta}/rechazar", nil, id_usuario)
  end

  def aceptar_oferta(id_usuario, id_oferta)
    post("/ofertas/#{id_oferta}/aceptar", nil, id_usuario)
  end

  private

  def post(url_relativa, json_body, id_usuario)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.post(url, json_body, header(id_usuario))
    JSON.parse(response.body)
  end

  def put(url_relativa, json_body, id_usuario)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.put(url, json_body, header(id_usuario))
    JSON.parse(response.body)
  end

  def get(url_relativa, id_usuario)
    url = ENV['API_HEROKU_URL'] + url_relativa
    response = Faraday.get(url, nil, header(id_usuario))
    JSON.parse(response.body)
  end

  def header(id_usuario)
    { 'CONTENT_TYPE' => 'application/json',
      'API_TOKEN' => ENV['API_TOKEN'],
      'USR_TOKEN' => id_usuario.to_s }
  end
end
