import menuInicial.*

class Dificultad {

	const imageDificultad
	var property imageSeleccionada = ""
	const property position
	const property dificultadDescendiente

	method image() = imageDificultad + imageSeleccionada + ".png"

	method seleccionar() {
		imageSeleccionada = "_seleccionada"
	}

	method deseleccionar() {
		imageSeleccionada = ""
	}

}

object dificultadUno inherits Dificultad(imageDificultad = "dificultad_uno", imageSeleccionada = "_seleccionada", position = start.position().down(3), dificultadDescendiente = true) {

}

object dificultadDos inherits Dificultad(imageDificultad = "dificultad_dos", position = dificultadUno.position().down(2), dificultadDescendiente = false) {

}
