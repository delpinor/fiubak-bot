require 'spec_helper'
require 'web_mock'
require_relative '../spec/helpers/bot_helpers'
# Uncomment to use VCR
# require 'vcr_helper'

describe 'Bot de telegram' do
  it 'Cuando le envio /start, entonces el bot response Hola' do
    token = 'fake_token'
    cuando_envio_un_mensaje(token, '/start')
    entonces_obtengo_el_mensaje(token, 'Hola, Nairobi')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio hola, entonces el bot response Hola' do
    token = 'fake_token'
    cuando_envio_un_mensaje(token, 'hola')
    entonces_obtengo_el_mensaje(token, 'Hola Nairobi')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /registrar al bot entonces obtengo un mensaje exitoso ' do
    token = 'fake_token'
    cuando_registro_un_usuario(token, '/registrar Juan, 9999, jua@gmail.com')
    entonces_obtengo_el_mensaje(token, 'registro exitoso')
    app = BotClient.new(token)
    app.run_once
  end

  it 'Cuando le envio /consultar_estado al bot entonces obtengo el estado de la intencion de venta ' do
    token = 'fake_token'
    cuando_registro_el_estado(token, '/consultar_estado 21')
    entonces_obtengo_el_mensaje(token, 'la intencion de venta 21 se encuentra: en revision')
    app = BotClient.new(token)
    app.run_once
  end

  it 'cuando envio /ayuda entonces obtengo una lista donde veo /registrar Nombre, DNI, email' do
    token = 'fake_token'
    cuando_envio_un_mensaje(token, '/ayuda')
    entonces_obtengo_el_mensaje(token, 'Comandos disponibles:' + "\n" + '/registrar Nombre, DNI, email' + "\n" + '/nueva_venta marca, modelo, año, patente')
    app = BotClient.new(token)
    app.run_once
  end
end
