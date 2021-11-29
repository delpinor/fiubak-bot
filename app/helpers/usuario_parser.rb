class UsuarioParser
  def a_json(mensaje, id_chat)
    datos_array = mensaje.split(',')
    {
      id_chat: id_chat,
      nombre: datos_array[0].strip,
      dni: datos_array[1].to_i,
      email: datos_array[2].strip
    }.to_json
  end
end
