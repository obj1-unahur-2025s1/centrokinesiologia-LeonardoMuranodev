object kinesiologia {
  const pacientes = []
  const aparatos = []

  //Metodos de consulta
  method coloresDeAparatosSinRepetidos() = aparatos.map({a => a.color()}).asSet()
  method menoresDeOchoAños() = pacientes.filter({p => p.edad() < 8})
  method cantNoPuedenCumplirConSuSesion() = pacientes.count({p => not p.puedeHacerLaRutina()})
  method estaEnOptimasCondiciones() = aparatos.all({a => ! a.necesitaMantenimiento()})
  method estaComplicado() = self.cantQueNecesitanMantenimiento() < aparatos.size() / 2
  method cantQueNecesitanMantenimiento() = aparatos.count({a => a.necesitaMantenimiento()})

  //Metodos de indicacion
  method visitaAlTecnico() {
    aparatos.forEach{a => a.realizarMantenimiento()}
  }

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
  var imantacion = 800

  //Metodos de consulta
  method puedeSerUsado(unPaciente) = true
  method necesitaMantenimiento() = imantacion < 100

  //Metodos de indicacion
  method esUsadoPor(unPaciente) {
    unPaciente.dolor(unPaciente.dolor() * 0.9)
    imantacion= 0.max(imantacion - 1)
  }

  method realizarMantenimiento() {
    if(self.necesitaMantenimiento()) {
      imantacion += 500
    }
  }
}

class Bicicleta {
  var property color = "blanco"
  var cantPerdidaAceite = 0
  var cantDesajusteTornillo = 0 

  //Metodos de consulta
  method necesitaMantenimiento() = cantDesajusteTornillo >= 10 || cantPerdidaAceite >= 5
  method puedeSerUsado(unPaciente) = unPaciente.edad() > 8

  //Metodos de indicacion
  method esUsadoPor(unPaciente) {
    if (unPaciente.dolor() > 30) {
      cantDesajusteTornillo += 1
    }

    if (unPaciente.edad() >= 30 && unPaciente.edad() <= 50) {
      cantPerdidaAceite += 1
    }
    unPaciente.dolor(unPaciente.dolor() - 4)
    unPaciente.fortaleza(unPaciente.fortaleza() + 3)
  }

  method realizarMantenimiento() {
    if(self.necesitaMantenimiento()) {
      cantDesajusteTornillo = 0
      cantPerdidaAceite = 0
    }
  }
}

class Minitramp {
  var property color = "blanco"

  //Metodos de consulta
  method puedeSerUsado(unPaciente) = 20 > unPaciente.dolor()
  method necesitaMantenimiento() = false

  //Metodos de indicacion
  method esUsadoPor(unPaciente) {
    unPaciente.fortaleza(unPaciente.fortaleza() + unPaciente.edad() * 0.1)
  }

  method realizarMantenimiento() {}
}
