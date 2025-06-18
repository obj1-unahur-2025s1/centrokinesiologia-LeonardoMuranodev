object kinesiologia {
  const pacientes = []
  const aparatos = []

  //Metodos de consulta
  method coloresDeAparatosSinRepetidos() = aparatos.map({a => a.color()}).asSet()
  method menoresDeOchoAños() = pacientes.filter({p => p.edad() < 8})
  method cantNoPuedenCumplirConSuSesion() = pacientes.count({p => not p.puedeHacerLaRutina()})

  //Metodos de indicacion
  method agregarPacientes(listaPacientes) {
    pacientes.addAll(listaPacientes)
  }

  method agregarAparatos(listaAparatos) {
    pacientes.addAll(listaAparatos)
  }
}

class Paciente {
  const aparatosRutina = []
  const property edad
  var property fortaleza
  var property dolor

  method puedeHacerLaRutina() = aparatosRutina.all({aparato => aparato.puedeSerUsado(self)})
  method cantidadDeAparatos() = aparatosRutina.size()

  method usar(unAparato) {
    if(unAparato.puedeSerUsado(self)) unAparato.esUsadoPor(self)
  }

  method realizarSesionCompleta(){
    if (self.puedeHacerLaRutina()) {
      aparatosRutina.forEach({aparato => aparato.esUsadoPor(self)})
    }
  }

  method agregarARutina(unAparato) {
    aparatosRutina.add(unAparato)
  }

  method agregarVariosARutina(listaAparatos) {
    aparatosRutina.addAll(listaAparatos)
  }
}

class Resistente inherits Paciente {
  override method realizarSesionCompleta() {
    super()
    fortaleza += self.cantidadDeAparatos()
  }
}

class Caprichoso inherits Paciente {

  override method puedeHacerLaRutina() = super() and aparatosRutina.any({a => a.color() == "rojo"})
  override method realizarSesionCompleta() {
    super()
    super()
  }
}

class RapidaRecuperacion inherits Paciente {


  override method realizarSesionCompleta() {
    super()
    dolor -= rapidosDeRecuperacion.cantidadConfigurable()
  }
}

object rapidosDeRecuperacion {
  var property cantidadConfigurable = 0
}

class Magneto {
  var property color = "blanco"

  method puedeSerUsado(unPaciente) = true

  method esUsadoPor(unPaciente) {
    unPaciente.dolor(unPaciente.dolor() * 0.9)
  }
}

class Bicicleta {
  var property color = "blanco"

  method puedeSerUsado(unPaciente) = unPaciente.edad() > 8

  method esUsadoPor(unPaciente) {
    unPaciente.dolor(unPaciente.dolor() - 4)
    unPaciente.fortaleza(unPaciente.fortaleza() + 3)
  }
}

class Minitramp {
  var property color = "blanco"
  method puedeSerUsado(unPaciente) = 20 > unPaciente.dolor()

  method esUsadoPor(unPaciente) {
    unPaciente.fortaleza(unPaciente.fortaleza() + unPaciente.edad() * 0.1)
  }
}
