require 'spec_helper'
require_relative '../app/helpers/usuario_parser.rb'

describe 'Usuario parser' do
  let(:mensaje) { 'Juan,33454678, juan@gmail.com' }
  let(:usuario) { UsuarioParser.new.a_json(mensaje) }

  it 'Al parsear tengo el dni' do
    expect(JSON.parse(usuario)['dni']).to eq 33_454_678
  end

  it 'Al parsear tengo el nombre' do
    expect(JSON.parse(usuario)['nombre']).to eq 'Juan'
  end

  it 'Al parsear tengo el email' do
    expect(JSON.parse(usuario)['email']).to eq 'juan@gmail.com'
  end
end
