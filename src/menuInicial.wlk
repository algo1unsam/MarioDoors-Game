import wollok.game.*
import dificultades.*
import teclado.*
import torreDePuertas.*

object start {

	const property position = game.at(0, game.height()).down(5)
	const property image = "start.png"

}

object menuOpciones {

	const property position = game.at(0, 0).up(3)
	const property image = "menu_opciones.png"

}

object menuInicial {

	const dificultades = [ dificultadUno, dificultadDos ]

	method agregarOpciones() {
		game.addVisual(start)
		dificultades.forEach({ dificultad => game.addVisual(dificultad)})
		game.addVisual(menuOpciones)
	}

	method iniciar() {
		self.agregarOpciones()
		teclado.configurarTeclasMenuInicial()
	}

	method seleccionar(dificultadSeleccionada) {
		dificultades.forEach({ dificultad => dificultad.deseleccionar()})
		dificultadSeleccionada.seleccionar()
		torreDePuertas.dificultadDescendiente(dificultadSeleccionada.dificultadDescendiente())
	}

}

