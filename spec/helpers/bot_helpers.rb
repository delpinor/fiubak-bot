require 'spec_helper'
require 'web_mock'
# Uncomment to use VCR
# require 'vcr_helper'

require "#{File.dirname(__FILE__)}/../../app/bot_client"

def get_updates_mock(token, message_text)
  body = {
    "ok": true, "result": [{ "update_id": 693_981_718,
                             "message": {
                               "message_id": 11,
                               "from": { "id": 141_733_544, "is_bot": false, "first_name": 'Nairobi', "last_name": 'Gutter', "username": 'egutter', "language_code": 'en' },
                               "chat": { "id": 141_733_544, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                               "date": 1_557_782_998, "text": message_text,
                               "entities": [{ "offset": 0, "length": 6, "type": 'bot_command' }]
                             } }]
  }
  stub_request(:any, "https://api.telegram.org/bot#{token}/getUpdates").to_return(body: body.to_json, status: 200, headers: { 'Content-Length' => 3 })
end

def send_message_mock(token, message_text)
  body = { "ok": true,
           "result": { "message_id": 12,
                       "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                       "chat": { "id": 141_733_544, "first_name": 'Nairobi', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                       "date": 1_557_782_999, "text": message_text } }

  stub_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")
    .with(
      body: { 'chat_id' => '141733544', 'text' => message_text }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def cuando_envio_un_mensaje(token, message_text)
  get_updates_mock(token, message_text)
end

def cuando_solicito_la_busqueda_de_publicaciones(token, publicaciones_mock, message_text)
  get_updates_mock(token, message_text)

  stub_request(:get, 'https://test.api/publicaciones')
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: publicaciones_mock.to_json, headers: {})
end

def entonces_obtengo_el_mensaje(token, message_text)
  send_message_mock(token, message_text)
end

def cuando_registro_un_usuario(token, message_text)
  get_updates_mock(token, message_text)

  stub_request(:post, 'https://test.api/usuarios')
    .with(
      body: '{"id":141733544,"nombre":"Juan","dni":9999,"email":"jua@gmail.com"}',
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/json',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: { mensaje: 'Registro exitoso bajo id: 141733544' }.to_json, headers: {})
end

def cuando_consulto_el_estado(token, message_text)
  get_updates_mock(token, message_text)

  resultado = {
    "mensaje": 'intencion de venta recuperadas con exito',
    "valor": {
      "auto": {
        "patente": 'patente',
        "marca": 'marca',
        "modelo": 'modelo',
        "anio": 4544,
        "id": 23
      },
      "estado": 'en revision',
      "id": 21
    }
  }
  stub_request(:get, 'https://test.api/intenciones_de_venta/21')
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: resultado.to_json, headers: {})
end

def cuando_registro_una_publicacion_por_p2p(token, message_text)
  get_updates_mock(token, message_text)

  stub_request(:post, 'https://test.api/publicaciones')
    .with(
      body: '{"id_intencion_de_venta":1,"tipo":"p2p","precio":45000}',
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/json',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: { mensaje: 'La intención de venta 1 se público en formato P2P, cotizada en 45000' }.to_json, headers: {})
end

def cuando_rechazo_una_oferta(token, message_text)
  get_updates_mock(token, message_text)
  stub_request(:post, 'https://test.api/ofertas/1/rechazar').
    with(
      body: "{\"id_publicacion\":1,\"precio\":45000}",
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/json',
        'User-Agent'=>'Faraday v0.15.4'
      }).
    to_return(status: 200, body: { mensaje: 'La oferta por la publicacion 1 se rechazo con exito, y la publicacion se publica en 45000' }.to_json, headers: {})

  end

def cuando_consulto_el_estado_inexistente(token, message_text)
  get_updates_mock(token, message_text)

  resultado = {
    "mensaje": 'intencion de venta no encontrada'
  }
  stub_request(:get, 'https://test.api/intenciones_de_venta/-1')
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: resultado.to_json, headers: {})
end

def cuando_registro_una_oferta_p2p(token, message_text)
  get_updates_mock(token, message_text)

  stub_request(:post, 'https://test.api/publicaciones/1/ofertas')
    .with(
      body: '{"id_usuario":141733544,"valor":35}',
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/json',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: { mensaje: 'Generaste la oferta #1 por Fiat Uno de $35', valor: { id: 1, valor: 35 } }.to_json, headers: {})
end

def cuando_consulto_el_estado_de_la_publicacion(token, message_text)
  get_updates_mock(token, message_text)
  # 21, marca: Fiat, modelo: Uno, anio: 1995, patente: 'MHF-200', precio: 75000\nofertas:\n [#1 monto_ofertado: 45000]
  resultado = {
    "id": 21,
    "marca": 'Fiat',
    "modelo": 'Uno',
    "anio": 1995,
    "patente": 'MHF-200',
    "precio": 75_000,
    "ofertas": [
      { "id": 1, "valor": 45_000 }
    ]
  }

  stub_request(:get, 'https://test.api/publicaciones/21')
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 200, body: resultado.to_json, headers: {})
end

def cuando_consulto_el_estado_de_la_publicacion_inexistente(token, message_text)
  get_updates_mock(token, message_text)
  # 21, marca: Fiat, modelo: Uno, anio: 1995, patente: 'MHF-200', precio: 75000\nofertas:\n [#1 monto_ofertado: 45000]
  resultado = {
    "mensaje": 'La publicacion no existe'
  }

  stub_request(:get, 'https://test.api/publicaciones/42')
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v0.15.4'
      }
    )
    .to_return(status: 404, body: resultado.to_json, headers: {})
end
