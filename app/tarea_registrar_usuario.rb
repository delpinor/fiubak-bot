require_relative  '../app/helpers/usuario_parser'
require_relative  '../app/api/usuarios_api'

class TareaRegistrarUsuario
  def procesar(message, datos)
    datos_json = UsuarioParser.new.a_json(datos, message.chat.id)
    mensaje = UsuariosApi.new('/usuarios').post(datos_json)
    mensaje
  end
end
