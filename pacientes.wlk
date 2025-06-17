class Paciente {
  const property edad
  var property fortaleza
  var property dolor

  //Metodos de consulta
  //method edad() = edad
  //method dolor() = dolor
  //method fortaleza() = fortaleza

  method usar(unAparato) {
    if(unAparato.puedeSerUsado(self)) unAparato.esUsadoPor(self)
  }
}

class Magneto {
  method puedeSerUsado(unPaciente) = true

  method esUsadoPor(unPaciente) {
    unPaciente.dolor(unPaciente.dolor() * 0.9)
  }
}

class Bicicleta {
  method puedeSerUsado(unPaciente) = unPaciente.edad() > 8

  method esUsadoPor(unPaciente) {
    unPaciente.dolor(unPaciente.dolor() - 4)
    unPaciente.fortaleza(unPaciente.fortaleza() + 3)
  }
}

class Minitramp {
  method puedeSerUsado(unPaciente) = 20 > unPaciente.dolor()

  method esUsadoPor(unPaciente) {
    unPaciente.fortaleza(unPaciente.fortaleza() + unPaciente.edad() * 0.1)
  }
}
