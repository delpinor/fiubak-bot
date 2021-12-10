require_relative '../app/api/web_api'
require_relative '../app/helpers/publicacion_parser'
require_relative '../app/tarea'

class TareaPublicarPorP2P < Tarea
  def procesar(_message, datos)
    datos_json = PublicacionParser.new.a_json(datos)
    web = WebApi.new('/publicaciones').post(datos_json)
    web.mensaje_de_respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
