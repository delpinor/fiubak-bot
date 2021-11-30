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

  it 'cuando envio /ayuda entonces obtengo una lista donde veo /registrar Nombre, DNI, email' do
    token = 'fake_token'

    cuando_envio_un_mensaje(token, '/ayuda')
    entonces_obtengo_el_mensaje(token, 'Comandos disponibles:' + ' /registrar Nombre, DNI, email')

    app = BotClient.new(token)

    app.run_once
  end
end
