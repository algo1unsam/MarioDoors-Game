import wollok.game.*
import torreDePuertas.*
import personajes.*

object tablero {

	method crearDimensiones() {
		game.width(15)
		game.height(12)
		game.cellSize(50)
	}

	method agregarTorreDePuertas() {
		torreDePuertas.agregarAlTablero()
	}

	method agregarPersonajes() {
		game.addVisual(mario)
		game.addVisual(luigi)
	}

}

