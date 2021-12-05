require 'spec_helper'
require_relative '../../app/helpers/publicacion_parser.rb'

describe 'Publicacion parser' do
  let(:mensaje) { '123,p2p,45000' }
  let(:publicacion) { PublicacionParser.new.a_json(mensaje) }

  it 'Al parsear tengo el dni' do
    expect(JSON.parse(publicacion)['id_intencion_de_venta']).to eq 123
  end
end
