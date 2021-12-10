require_relative '../app/api/web_api'
require_relative '../app/helpers/oferta_parser'
require_relative '../app/tarea'

class TareaOfertarPorP2P < Tarea
  def procesar(message, datos)
    id = message.chat.id
    datos_json, id_publicacion = OfertaParser.new.a_json(datos, id)
    web = WebApi.new("/publicaciones/#{id_publicacion}/ofertas").post(datos_json)
    web.mensaje_de_respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
