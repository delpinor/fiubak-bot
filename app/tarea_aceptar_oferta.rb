require_relative '../app/api/web_api'
require_relative '../app/helpers/publicacion_parser'

class TareaAceptarOferta
  def procesar(_message, id_oferta)
    respuesta = WebApi.new('/').aceptar_oferta(id_oferta)
    respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
