require_relative '../helpers/datos_usuario'

class UsuarioParser
  def parsear(mensaje)
    campos_datos = mensaje.split(',')
    DatosUsuario.new(campos_datos[0], campos_datos[1], campos_datos[2])
  end
end
