require_relative '../app/api/web_api'
require_relative '../app/tarea'
require_relative '../app/fabrica_emoji'

class TareaConsultarPublicacion < Tarea
  def procesar(message, id_publicacion)
    respuesta = WebApi.new.obtener_publicacion(message.chat.id, id_publicacion)
    if respuesta.key?('id')
      id_publicacion = respuesta['id']
      marca = respuesta['marca']
      modelo = respuesta['modelo']
      anio = respuesta['anio']
      patente = respuesta['patente']
      precio = respuesta['precio']
      titulo = "Datos del auto: #{FabricaEmoji.emoji(:auto)} \n \n" \
               "Id. Publicación: #{id_publicacion}" + "\n" \
               "Marca: #{marca}" + "\n" \
               "Modelo: #{modelo}" + "\n" \
               "Patente: #{patente}" + "\n" \
               "Año: #{anio}" + "\n" \
               "Precio: $#{precio}" + "\n"
      titulo + "\n" + listar_ofertas(respuesta['ofertas'])
    else
      respuesta['mensaje']
    end
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end

  private

  def listar_ofertas(ofertas)
    resultado = "Ofertas recibidas: #{FabricaEmoji.emoji(:plata)} \n \n"
    ofertas.each do |oferta|
      resultado += "#{FabricaEmoji.emoji(:item)} Nro. #{oferta['id']}: #{oferta['nombre_comprador']} ofreció el monto de $#{oferta['valor']}" + "\n"
    end
    resultado
  end
end
