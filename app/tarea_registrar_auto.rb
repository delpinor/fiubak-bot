require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'
require_relative '../app/tarea'

class TareaRegistrarAuto < Tarea
  def procesar(message, datos_auto)
    respuesta = WebApi.new('/').registrar_auto(message.chat.id, datos_auto)
    respuesta['mensaje']
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
