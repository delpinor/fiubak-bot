require_relative '../app/helpers/usuario_parser'
require_relative '../app/api/web_api'

class TareaRegistrarUsuario
  def procesar(message, datos)
    datos_json = UsuarioParser.new.a_json(datos, message.chat.id)
    mensaje = WebApi.new('/usuarios').post(datos_json)
    mensaje
  end
end
