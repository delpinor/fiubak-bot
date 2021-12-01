require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'

class TareaRegistrarAuto
  def procesar(message, datos)
    datos_json = AutoParser.new.a_json(datos)
    id = message.chat.id
    web = WebApi.new("/usuarios/#{id}/intenciones_de_venta").post(datos_json)
    id_registro = web.id_de_respuesta
    "La intencion de venta #{id_registro} se registró con exito"
  end
end
