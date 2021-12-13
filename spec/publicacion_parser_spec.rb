require 'spec_helper'
require_relative '../app/helpers/publicacion_parser'

describe 'Publicacion parser' do
  let(:mensaje) { '123,p2p,45000' }
  let(:publicacion) { PublicacionParser.new.a_json(mensaje) }

  it 'Al parsear tengo el id_intencion_de_venta' do
    expect(JSON.parse(publicacion)['id_intencion_de_venta']).to eq 123
  end

  it 'Al parsear tengo el tipo' do
    expect(JSON.parse(publicacion)['tipo']).to eq 'p2p'
  end

  it 'Al parsear tengo el precio' do
    expect(JSON.parse(publicacion)['precio']).to eq 45_000
  end
end
