import wollok.game.*
import elementosVisibles.*
import dificultades.*
import teclado.*
import torreDePuertas.*

object start inherits ElementoVisible(image = "start.png", position = game.at(0, game.height()).down(5)) {

}

object menuOpcionesIniciales inherits ElementoVisible(image = "menu_opciones.png", position = game.at(0, 0).up(3)) {

}

object gameOver inherits ElementoVisible(image = "game_over.png", position = game.at(0, game.height()).down(5)) {

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
		start.mostrar()
		dificultades.forEach({ dificultad => dificultad.mostrar()})
		menuOpcionesIniciales.mostrar()
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
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuFinal()
	}

}

