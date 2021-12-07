require 'spec_helper'
require_relative '../../app/helpers/rechazar_oferta_parser.rb'

describe 'Rechazo oferta parser' do
  let(:mensaje) { '123,45000' }
  let(:publicacion) { RechazarOfertaParser.new.a_json(mensaje) }

  it 'Al parsear tengo el id_publicacion' do
    expect(JSON.parse(publicacion)['id_publicacion']).to eq 123
  end

end