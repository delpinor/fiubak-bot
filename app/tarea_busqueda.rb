require_relative '../app/api/web_api'

class TareaBusqueda
  def procesar(_message, _datos)
    req = WebApi.new('/publicaciones').get
    data_json = req.valor_de_respuesta_de_busqueda
    return 'No hay publicaciones disponibles' if data_json.empty?
    result = ''
    data_json.each do |auto|
      result += "##{auto[:id]}, " \
                "marca: #{auto[:marca]}, " \
                "modelo: #{auto[:modelo]}, " \
                "anio: #{auto[:anio]}, " \
                "precio: #{auto[:precio]}" + "\n"
    end
    result
  rescue StandardError
    'Ups! Hubo un problema. Verificá los datos.'
  end
end
