class Dificultad {

	var property dificultad = 1
	var property velocidadPersonajes = dificultad

	method cantidadPuertasPorNivel() = dificultad * 6

}

object dificultadFacil inherits Dificultad() {
	
}

object dificultadIntermedia inherits Dificultad(dificultad = 2) {

}

object dificultadDificil inherits Dificultad(dificultad = 3) {

}

