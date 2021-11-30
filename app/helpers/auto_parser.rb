class AutoParser
  def a_json(mensaje)
    datos_array = mensaje.split(',')
    {
      marca: datos_array[0].strip,
      modelo: datos_array[1].strip,
      anio: datos_array[2].to_i,
      patente: datos_array[3].strip
    }.to_json
  end
end
