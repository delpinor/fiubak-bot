class TareaAyuda
  def procesar(_message, _datos = nil)
    'Comandos disponibles:' + "\n" \
      '/registrar Nombre, DNI, email' + "\n" \
      '/nueva_venta marca, modelo, año, patente' + "\n" \
      '/consultar_estado id_intencion_de_venta' + "\n" \
      '/aceptar_cotizacion id_intencion_de_venta' + "\n" \
      '/busqueda'
  end
end
