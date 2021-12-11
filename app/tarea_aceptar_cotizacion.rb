require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaAceptarCotizacion < Tarea
  def procesar(message, id_intencion)
    respuesta = WebApi.new('/').aceptar_cotizacion(message.chat.id, id_intencion)
    respuesta['mensaje']
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
