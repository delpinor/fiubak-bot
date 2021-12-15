# rubocop:disable all

require 'spec_helper'
require 'web_mock'
require_relative '../spec/helpers/bot_helpers'
# Uncomment to use VCR
# require 'vcr_helper'

describe 'Bot de telegram' do

  it 'Cuando le envio un comando desconocido response que no entiede' do
    token = 'fake_token'
    cuando_envio_un_mensaje(token, '/desconocido')
    entonces_obtengo_el_mensaje(token, "No te entiendo, pero esto te puede ayudar: \n \n #{TareaAyuda.new.procesar(nil, nil)}")
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio hola, entonces el bot response Hola' do
    token = 'fake_token'
    cuando_envio_un_mensaje(token, 'hola')
    entonces_obtengo_el_mensaje(token, 'Hola Nairobi 😃')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /registrar al bot entonces obtengo un mensaje exitoso ' do
    token = 'fake_token'
    cuando_registro_un_usuario(token, '/registrar Juan, 9999, jua@gmail.com')
    entonces_obtengo_el_mensaje(token, 'Registro exitoso bajo id: 141733544')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /consultar_estado al bot entonces obtengo el estado de la intencion de venta ' do
    token = 'fake_token'
    cuando_consulto_el_estado(token, '/consultar_estado 21')
    entonces_obtengo_el_mensaje(token, 'La intención de venta 21 se encuentra: en revision ')
    app = BotClient.new(token)
    app.run_once
  end

  it 'cuando envio /ayuda entonces obtengo una lista donde veo /registrar Nombre, DNI, email' do
    mensaje_esperado = "💁 Comandos disponibles:\n \n/registrar Nombre, DNI, email\n/nueva_venta marca, modelo, año, patente\n/consultar_estado id_intencion_de_venta\n/aceptar_cotizacion id_intencion_de_venta\n/busqueda\n/rechazar id_intencion_de_venta, precio\n/ofertar id_publicacion,precio\n/consultar_publicacion id_publicacion\n/rechazar_oferta id_oferta\n/aceptar_oferta id_oferta\n/test_drive id_publicacion"
    token = 'fake_token'
    cuando_envio_un_mensaje(token, '/ayuda')
    entonces_obtengo_el_mensaje(token, mensaje_esperado)
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /busqueda al bot entonces obtengo un mensaje de que no hay publicaciones' do
    token = 'fake_token'
    publicaciones_mock = []
    mensaje_esperado = "No hay publicaciones disponibles 😔"
                       
    cuando_solicito_la_busqueda_de_publicaciones(token, publicaciones_mock, '/busqueda')
    entonces_obtengo_el_mensaje(token, mensaje_esperado)
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /busqueda al bot entonces obtengo las publicaciones' do
    token = 'fake_token'
    publicaciones_mock = [
      {id: 1, marca: "Fiat", modelo: "Uno", anio: 1995, precio: 75000, tipo: "Fiubak"},
      {id: 2, marca: "Fiat2", modelo: "Uno", anio: 1996, precio: 76000, tipo: "Fiubak"},
      {id: 3, marca: "Fiat3", modelo: "Uno", anio: 1997, precio: 77000, tipo: "Fiubak"}
    ]
    mensaje_esperado = "🚗 Auto publicados: \n \n➡Id. de publicación: 1\nMarca: Fiat\nModelo: Uno\nAño: 1995\nPrecio: $75000\nTipo de publicación: Fiubak\n \n➡Id. de publicación: 2\nMarca: Fiat2\nModelo: Uno\nAño: 1996\nPrecio: $76000\nTipo de publicación: Fiubak\n \n➡Id. de publicación: 3\nMarca: Fiat3\nModelo: Uno\nAño: 1997\nPrecio: $77000\nTipo de publicación: Fiubak\n \n"
                       
    cuando_solicito_la_busqueda_de_publicaciones(token, publicaciones_mock, '/busqueda')
    entonces_obtengo_el_mensaje(token, mensaje_esperado)
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio un POST /publicaciones al bot entonces obtengo un mensaje de registro exitoso' do
    token = 'fake_token'
    cuando_registro_una_publicacion_por_p2p(token, '/rechazar 1,45000')
    entonces_obtengo_el_mensaje(token, 'La intención de venta 1 se público en formato P2P, cotizada en 45000')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio un POST ofertas/#{pub_id}/rechazar al bot entonces obtengo un mensaje de rechazo de oferta exitoso' do
    token = 'fake_token'
    cuando_rechazo_una_oferta(token, '/rechazar_oferta 1')
    entonces_obtengo_el_mensaje(token, 'oferta rechazada con exito')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio un POST /aceptar_oferta al bot entonces obtengo un mensaje de rechazo de oferta exitoso' do
    token = 'fake_token'
    cuando_acepto_una_oferta(token, '/aceptar_oferta 1')
    entonces_obtengo_el_mensaje(token, 'oferta aceptada con exito')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /consultar_estado al bot con un id de intencion de venta inexistente entonces obtengo respondo con un mensaje de error' do
    token = 'fake_token'
    cuando_consulto_el_estado_inexistente(token, '/consultar_estado -1')
    entonces_obtengo_el_mensaje(token, 'intencion de venta no encontrada')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /ofertar 1, 35 al bot con una publicacion valida obtengo un mensaje de oferta generada' do
    token = 'fake_token'
    cuando_registro_una_oferta_p2p(token, '/ofertar 1,35')
    entonces_obtengo_el_mensaje(token, 'Generaste la oferta #1 por Fiat Uno de $35')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /test_drive 1 al bot con una publicacion valida obtengo un mensaje de oferta generada' do
    token = 'fake_token'
    cuando_solicito_un_test_drive(token, '/test_drive 1')
    entonces_obtengo_el_mensaje(token, 'Test-drive para el día de hoy contratado con éxito. Deberá abonar una suma de $12')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /consultar_publicacion al bot entonces obtengo el detalle de la publicacion' do
    token = 'fake_token'
    mensaje_esperado = "Datos del auto: 🚗 \n \nId. Publicación: 21\nMarca: Fiat\nModelo: Uno\nPatente: MHF-200\nAño: 1995\nPrecio: $75000\n\nOfertas recibidas: 💲 \n \n➡ Nro. 1: Juan ofreció el monto de $75000\n"
    cuando_consulto_el_estado_de_la_publicacion(token, '/consultar_publicacion 21')
    entonces_obtengo_el_mensaje(token, mensaje_esperado)
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /consultar_publicacion con id inexistente entonces el bot me avisa el error' do
    token = 'fake_token'
    mensaje_esperado = "La publicacion no existe"
    cuando_consulto_el_estado_de_la_publicacion_inexistente(token, '/consultar_publicacion 42')
    entonces_obtengo_el_mensaje(token, mensaje_esperado)
    app = BotClient.new(token)
    app.run_once
  end
end