require_relative '../app/api/web_api'
require_relative '../app/helpers/publicacion_parser'
require_relative '../app/tarea'

class TareaRechazarOferta < Tarea
  def procesar(_message, id_oferta)
    respuesta = WebApi.new('/').rechazar_oferta(id_oferta)
    respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
