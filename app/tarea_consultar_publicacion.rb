require_relative '../app/api/web_api'
require_relative '../app/tarea'

class TareaConsultarPublicacion < Tarea
  def procesar(_message, datos)
    req = WebApi.new("/publicaciones/#{datos}").get
    data_json = req.valor_de_respuesta_de_publicaciones
    if !data_json.nil?
      id_publicacion = data_json['id']
      marca = data_json['marca']
      modelo = data_json['modelo']
      anio = data_json['anio']
      patente = data_json['patente']
      precio = data_json['precio']
      result = "##{id_publicacion}, marca: #{marca}, modelo: #{modelo}, anio: #{anio}, patente: #{patente}, precio: #{precio}\n"
      result += "ofertas:\n"
      data_json['ofertas'].each do |oferta|
        result += "##{oferta['id']} #{oferta['nombre_comprador']} ofreció el monto de $#{oferta['valor']}" + "\n"
      end
      result
    else
      req.mensaje_de_respuesta
    end
  rescue StandardError
    return req.mensaje_de_respuesta if req

    'Ups! Hubo un problema. Verificá los datos.'
  end
end
