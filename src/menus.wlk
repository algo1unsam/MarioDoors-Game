import wollok.game.*
import elementosVisibles.*
import dificultades.*
import teclado.*
import torreDePuertas.*

object title inherits ElementoVisible(image = "mario_doors_game.png", position = game.at(0, game.height()).down(5)) {

}

object start inherits ElementoVisible(image = "start.png", position = title.position().down(5)) {

}

object gameOver inherits ElementoVisible(image = "game_over.png", position = game.at(0, game.height()).down(5)) {

}

object restart inherits ElementoVisible(image = "restart.png", position = gameOver.position().down(5)) {

}

object exit inherits ElementoVisible(image = "exit.png", position = restart.position().down(1)) {

}

class Menu {

	method agregarOpciones()

	method iniciar() {
		self.agregarOpciones()
	}

}

object menuInicial inherits Menu {

	const dificultades = [ dificultadUno, dificultadDos ]

	override method agregarOpciones() {
		title.mostrar()
		start.mostrar()
		dificultades.forEach({ dificultad => dificultad.mostrar()})
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuInicial()
	}

	method seleccionar(dificultadSeleccionada) {
		dificultades.forEach({ dificultad => dificultad.deseleccionar()})
		dificultadSeleccionada.seleccionar()
		torreDePuertas.dificultadDescendiente(dificultadSeleccionada.dificultadDescendiente())
	}

}

object menuFinal inherits Menu {

	override method agregarOpciones() {
		gameOver.mostrar()
		restart.mostrar()
		exit.mostrar()
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuFinal()
	}

}

