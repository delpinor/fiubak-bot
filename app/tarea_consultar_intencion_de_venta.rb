require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'

class TareaConsultarIntencionDeVenta
  def procesar(_message, datos)
    mensaje = WebApi.new("/intenciones_de_venta/#{datos}").get
    mensaje
  end
end
