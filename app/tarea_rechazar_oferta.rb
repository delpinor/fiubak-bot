require_relative '../app/api/web_api'
require_relative '../app/helpers/publicacion_parser'
require_relative '../app/tarea'

class TareaRechazarOferta < Tarea
  def procesar(message, id_oferta)
    respuesta = WebApi.new('/').rechazar_oferta(message.chat.id, id_oferta)
    respuesta['mensaje']
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
