require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaBusqueda < Tarea
  def procesar(_message, _datos)
    respuesta = WebApi.new.obtener_publicaciones
    return "No hay publicaciones disponibles #{FabricaEmoji.emoji(:triste)}" if respuesta.empty?

    resultado = "#{FabricaEmoji.emoji(:auto)} Auto publicados: " + "\n \n"
    respuesta.each do |auto|
      resultado += "#{FabricaEmoji.emoji(:item)}" \
                   "Id. de publicación: #{auto['id']}" + "\n" \
                   "Marca: #{auto['marca']}" + "\n" \
                   "Modelo: #{auto['modelo']}" + "\n" \
                   "Año: #{auto['anio']}" + "\n" \
                   "Precio: $#{auto['precio']}" + "\n" \
                   "Tipo de publicación: #{auto['tipo']}" + "\n \n"
    end
    resultado
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
