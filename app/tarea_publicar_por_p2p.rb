require_relative '../app/api/web_api'
require_relative '../app/helpers/publicacion_parser'
require_relative '../app/tarea'

class TareaPublicarPorP2P < Tarea
  def procesar(message, datos_publicacion)
    respuesta = WebApi.new('/').publicar_p2p(message.chat.id, datos_publicacion)
    respuesta['mensaje']
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
