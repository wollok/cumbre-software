class Pais {
	var property paisesEnConflicto = []	
	
	method registrarConflicto(pais) { paisesEnConflicto.add(pais) }
	
	method estaEnConflictoCon(pais) { return paisesEnConflicto.contains(pais) }
}


class Empresa {
	var property paises
	method esMultinacional() { return paises.size() > 2 }
}


class Actividad {
	var property tema
	var property horas
}