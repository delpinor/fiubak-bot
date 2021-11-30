require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'

class TareaRegistrarAuto
  def procesar(message, datos)
    datos_json = AutoParser.new.a_json(datos)
    id = message.chat.id
    mensaje = WebApi.new("/usuarios/#{id}/intenciones_de_venta").post(datos_json)
    mensaje
  end
end
