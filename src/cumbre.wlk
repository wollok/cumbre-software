object parametrosCumbre {
	var property requisitoCommitsProgramadores = 300	
}

object cumbre {
	var property paisesAuspiciantes = []
	var property personasRegistradas = []
	var property actividadesRealizadas = []
	
	method cumpleRestriccionesAcceso(candidato) {
		return not self.esPaisConflictivo(candidato.pais())
	} 
	
	method esPaisConflictivo(pais) {
		return paisesAuspiciantes.any{paisMiembro => paisMiembro.estaEnConflictoCon(pais) }
	}
	
	method puedeIngresar(candidato) {
		return self.cumpleRestriccionesAcceso(candidato) and candidato.cumpleRequisitosParaCumbre()
	}
	
	method paisesDeLosParticipantes() =
		personasRegistradas.map{pers => pers.pais()}.asSet()
		
	method cantidadParticipantesDePais(pais) =
		personasRegistradas.count{ pers => pers.pais() == pais }
		
	method paisConMasParticipantes() =
		self.paisesDeLosParticipantes().max{ pais => pais.cantidadParticipantesDePais(pais) }

	method darIngreso(candidato) {
		if (not self.puedeIngresar(candidato)) {
			self.error("El candidato no puede ingresar")
		}
		candidato.ingresarACumbre()
	}
	
	method registrarIngreso(persona) { personasRegistradas.add(persona) }
	
	method registrarActividad(acti) {
		actividadesRealizadas.add(acti)
		personasRegistradas.forEach{pers => pers.hizoActividad(acti)}
	}
}
