class RechazarOfertaParser
  def a_json(mensaje)
    datos_array = mensaje.split(',')
    {
      id_publicacion: datos_array[0].strip.to_i,
      precio: datos_array[1].strip.to_i
    }.to_json
  end
end