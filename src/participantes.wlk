import cumbre.*
import conocimientos.*

class Profesional {
	var property pais
	var property conocimientos = #{}
	var property commits = 0
	
	method cumpleRequisitosParaCumbre() = conocimientos.contains(programacionBasica)
	
	method ingresarACumbre() { cumbre.registrarIngreso(self) }
	
	method esCapo()
	
	method incorporarConocimiento(cono) { conocimientos.add(cono) }
	method agregarCommits(cuantos) { commits += cuantos }
	
	method hizoActividad(actividad) {
		self.incorporarConocimiento(actividad.tema())
		self.agregarCommits(actividad.tema().commitsPorHora() * actividad.horas())
	}
}

class Programador inherits Profesional {
	var property horasCapacitacion = 0
	
	override method cumpleRequisitosParaCumbre() = 
		super() and commits > parametrosCumbre.requisitoCommitsProgramadores()
		
	override method esCapo() { return commits > 500 }
	override method hizoActividad(actividad) {
		super(actividad)
		horasCapacitacion += actividad.horas()	
	}
}

class Especialista inherits Profesional {		
	override method cumpleRequisitosParaCumbre() =
		super() 
		and (commits > parametrosCumbre.requisitoCommitsProgramadores() - 100) 
		and conocimientos.contains(objetos)

	override method esCapo() { return conocimientos.size() > 2 }
}


class Gerente inherits Profesional {
	var property empresa
	var property asesor
		
	override method cumpleRequisitosParaCumbre() =
		super()
		and conocimientos.contains(manejoDeGrupos) 
		and empresa.paises().asSet().intersection(cumbre.paisesAuspiciantes()).size() >= 2

	override method ingresarACumbre() { 
		super()
		cumbre.registrarIngreso(asesor)
	}
	override method esCapo() { return empresa.esMultinacional() }
}

class Grupo {
	var property integrantes
	
	method pais() = integrantes.anyOne().pais()
	
	method cumpleRequisitosParaCumbre() =
		integrantes.filter{inte => not inte.cumpleRequisitosParaCumbre()}.size() <= 1 

	method ingresarACumbre() { 
		integrantes.forEach {inte => cumbre.registrarIngreso(inte)}
	}
}

