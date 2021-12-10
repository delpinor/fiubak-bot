require_relative '../app/helpers/usuario_parser'
require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaRegistrarUsuario < Tarea
  def procesar(message, datos)
    datos_json = UsuarioParser.new.a_json(datos, message.chat.id)
    web = WebApi.new('/usuarios').post(datos_json)
    web.mensaje_de_respuesta
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
