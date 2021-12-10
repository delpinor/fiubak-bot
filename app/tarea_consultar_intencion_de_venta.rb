require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'
require_relative '../app/tarea'

class TareaConsultarIntencionDeVenta < Tarea
  def procesar(_message, datos)
    req = WebApi.new("/intenciones_de_venta/#{datos}").get
    data_json = req.valor_de_respuesta
    if !data_json.nil?
      estado = data_json['estado']
      id = data_json['id']
      "la intencion de venta #{id} se encuentra: #{estado}"
    else
      req.mensaje_de_respuesta
    end
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
