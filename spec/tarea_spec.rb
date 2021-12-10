require 'spec_helper'
require_relative '../app/tarea.rb'

describe 'Tarea para comando' do
  it 'Debe lanzar una excepción al llamar procesar sin implementar' do
    tarea = Tarea.new
    expect { tarea.procesar(nil, nil) }.to raise_error(NotImplementedError)
  end
end
