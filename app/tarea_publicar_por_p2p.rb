require_relative '../app/api/web_api'

class TareaPublicarPorP2P
  def procesar(_message, datos)
    datos_json = PublicacionParser.new.a_json(datos)
    web = WebApi.new('/publicaciones').post(datos_json)
    id_intencion_de_venta = web.valor.id_intencion_de_venta
    "La intención de venta #{id_intencion_de_venta} se público en formato P2P, cotizada en #{precio}"
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
