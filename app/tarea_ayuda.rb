require_relative '../app/tarea'

class TareaAyuda < Tarea
  def procesar(_message, _datos = nil)
    "#{FabricaEmoji.emoji(:ayuda)} Comandos disponibles:" + "\n \n" \
      '/registrar Nombre, DNI, email' + "\n" \
      '/nueva_venta marca, modelo, año, patente' + "\n" \
      '/consultar_estado id_intencion_de_venta' + "\n" \
      '/aceptar_cotizacion id_intencion_de_venta' + "\n" \
      '/busqueda' + "\n" \
      '/publicar id_intencion_de_venta, p2p, precio' + "\n" \
      '/ofertar id_publicacion,precio' + "\n" \
      '/consultar_publicacion id_publicacion' + "\n" \
      '/rechazar_oferta id_oferta' + "\n" \
      '/aceptar_oferta id_oferta' + "\n" \
      '/test_drive id_publicacion'
  end
end
