class PublicacionParser
  def a_json(mensaje)
    datos_array = mensaje.split(',')
    {
      id_intencion_de_venta: datos_array[0].strip.to_i
    }.to_json
  end
end
