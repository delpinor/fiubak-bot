require_relative '../app/api/web_api'
require_relative '../app/helpers/publicacion_parser'

class TareaRechazarOferta
  def procesar(_message, datos)
    datos_json = PublicacionParser.new.a_json(datos)
    pub_id = datos['precio']
    web = WebApi.new("/publicaciones/#{pub_id}/ofertas/rechazar").post(datos_json)
    web.mensaje_de_respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end