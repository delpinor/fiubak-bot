require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'

class TareaConsultarIntencionDeVenta
  def procesar(_message, datos)
    req = WebApi.new("/intenciones_de_venta/#{datos}").get
    data_json = req.valor_de_respuesta
    estado = data_json['estado']
    id = data_json['id']
    "la intencion de venta #{id} se encuentra: #{estado}"
  end
end
