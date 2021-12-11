require_relative  '../app/helpers/auto_parser'
require_relative  '../app/api/web_api'
require_relative '../app/tarea'

class TareaConsultarIntencionDeVenta < Tarea
  def procesar(message, id_intencion)
    respuesta = WebApi.new.consultar_intencion_de_venta(message.chat.id, id_intencion)
    if respuesta.key?('valor')
      intencion_de_venta = respuesta['valor']
      estado = intencion_de_venta['estado']
      id = intencion_de_venta['id']
      "La intención de venta #{id} se encuentra: #{estado} #{emoji_segun_estado(estado)}"
    else
      respuesta['mensaje']
    end
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end

  def emoji_segun_estado(estado)
    if estado == 'en revisión'
      FabricaEmoji.emoji(:revision)
    elsif estado == 'revisado y cotizado'
      FabricaEmoji.emoji(:revisado_cotizado)
    elsif estado == 'vendido'
      FabricaEmoji.emoji(:vendido)
    elsif estado == 'rechazado'
      FabricaEmoji.emoji(:rechazado)
    elsif estado == 'publicado'
      FabricaEmoji.emoji(:publicado)
    end
  end
end
