class TareaAyuda
  def procesar(_message, _datos = nil)
    'Comandos disponibles:' + "\n" \
      '/registrar Nombre, DNI, email' + "\n" \
      '/nueva_venta marca, modelo, año, patente' + "\n" \
      '/consultar_estado id_intencion_de_venta' + "\n" \
      '/aceptar_cotizacion id_intencion_de_venta' + "\n" \
      '/busqueda' + "\n" \
      '/publicar id_intencion_de_venta, p2p, precio' + "\n" \
      '/ofertar id_publicacion,precio' + "\n" \
      '/consultar_publicacion id_publicacion'
  end
end
