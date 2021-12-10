require_relative '../app/helpers/usuario_parser'
require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaRegistrarUsuario < Tarea
  def procesar(message, datos_usuario)
    respuesta = WebApi.new('').registrar_usuario(message.chat.id, datos_usuario)
    respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
