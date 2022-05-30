import wollok.game.*
import dificultades.*
import teclado.*
import tablero.*

object pressEnter {

	const property position = game.at(0, game.height() / 2).up(1)
	const property image = "start.png"

}

object menuInicial {

	const dificultades = [ dificultadUno, dificultadDos ]

	method agregarOpciones() {
		game.addVisual(pressEnter)
		dificultades.forEach({ dificultad => game.addVisual(dificultad)})
	}

	method iniciar() {
		self.agregarOpciones()
		teclado.configurarTeclasMenuInicial()
	}

	method seleccionar(dificultadSeleccionada) {
		dificultades.forEach({ dificultad => dificultad.deseleccionar()})
		dificultadSeleccionada.seleccionar()
		tablero.setearDificultad(dificultadSeleccionada)
	}

}

