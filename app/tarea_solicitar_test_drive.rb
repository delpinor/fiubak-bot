require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaSolicitarTestDrive < Tarea
  def procesar(message, id_publicacion)
    respuesta = WebApi.new.solicitar_test_drive(message.chat.id, id_publicacion)
    respuesta['mensaje']
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
