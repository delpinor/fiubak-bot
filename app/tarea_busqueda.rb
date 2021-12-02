require_relative '../app/api/web_api'

class TareaBusqueda
  def procesar(_message, _datos)
    req = WebApi.new('/publicaciones').get
    data_json = req.valor_de_respuesta_de_busqueda
    result = ''
    data_json.each do |auto|
      auto_parsed = JSON.parse(auto)
      result += "id: #{auto_parsed['id']}, " \
                "marca: #{auto_parsed['marca']}, " \
                "modelo: #{auto_parsed['modelo']}, " \
                "año: #{auto_parsed['anio']}, " \
                "precio: #{auto_parsed['precio']}" + "\n"
    end
    result
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
