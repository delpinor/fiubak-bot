require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaAceptarCotizacion < Tarea
  def procesar(_message, datos)
    data_json = { id_intencion: datos }.to_json
    req = WebApi.new('/aceptar_cotizacion').put(data_json)
    req.mensaje_de_respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
