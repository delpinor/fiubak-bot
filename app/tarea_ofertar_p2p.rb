require_relative '../app/api/web_api'
require_relative '../app/helpers/oferta_parser'
require_relative '../app/tarea'

class TareaOfertarPorP2P < Tarea
  def procesar(message, datos_oferta)
    respuesta = WebApi.new('/').ofertar_p2p(message.chat.id, datos_oferta)
    respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
