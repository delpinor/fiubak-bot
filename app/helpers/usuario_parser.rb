class UsuarioParser
  def a_json(mensaje)
    datos_array = mensaje.split(',')
    {
      nombre: datos_array[0].strip,
      dni: datos_array[1].to_i,
      email: datos_array[2].strip
    }.to_json
  end
end
