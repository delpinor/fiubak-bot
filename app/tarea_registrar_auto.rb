require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'
require_relative '../app/tarea'

class TareaRegistrarAuto < Tarea
  def procesar(message, datos)
    datos_json = AutoParser.new.a_json(datos)
    id = message.chat.id
    web = WebApi.new("/usuarios/#{id}/intenciones_de_venta").post(datos_json)
    web.mensaje_de_respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
