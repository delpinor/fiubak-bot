class PublicacionParser
  def a_json(mensaje)
    datos_array = mensaje.split(',')
    {
      id_intencion_de_venta: datos_array[0].strip.to_i,
      tipo: datos_array[1].strip
    }.to_json
  end
end
