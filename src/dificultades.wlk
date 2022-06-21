import elementosVisibles.*
import menus.*

class Dificultad inherits ElementoVisible {

	var property imageSeleccionada = ""
	const property dificultadDescendiente

	override method image() = image + imageSeleccionada + ".png"

	method seleccionar() {
		imageSeleccionada = "_seleccionada"
	}

	method deseleccionar() {
		imageSeleccionada = ""
	}

}

object dificultadUno inherits Dificultad(image = "dificultad_uno", imageSeleccionada = "_seleccionada", position = start.position().down(2), dificultadDescendiente = true) {

}

object dificultadDos inherits Dificultad(image = "dificultad_dos", position = dificultadUno.position().down(1), dificultadDescendiente = false) {

}

