class PublicacionParser
  def a_json(mensaje)
    datos_array = mensaje.split(',')
    {
      id_intencion_de_venta: datos_array[0].strip.to_i,
      tipo: datos_array[1].strip,
      precio: datos_array[2].strip.to_i
    }.to_json
  end
end
