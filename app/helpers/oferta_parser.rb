class OfertaParser
  def a_json(mensaje, id)
    datos_array = mensaje.split(',')
    [{
      id_usuario: id,
      valor: datos_array[1].to_i
    }.to_json, datos_array[0].strip.to_i]
  end
end
