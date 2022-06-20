import wollok.game.*
import menuInicial.*
import torreDePuertas.*
import personajes.*
import teclado.*
import sonidos.*

object tablero {

	const sonidoDeFondo = "sonidoDeFondo.mp3"

	method setearFondo() {
		game.title("Mario Doors Game")
		game.cellSize(80)
		game.width(15)
		game.height(16)
		game.ground("fondo_negro.png")
	}

	method configurarTorreDePuertas() {
		torreDePuertas.agregarAlTablero()
	}

	method setearColisiones(personaje) {
		game.onCollideDo(personaje, { algo =>
			if (algo.esHabilidad()) {
				personaje.agarrar(algo)
			}
		})
	}

	method configurarPersonajes() {
		mario.mostrar()
		self.setearColisiones(mario)
		luigi.mostrar()
		self.setearColisiones(luigi)
	}

	method setearEntorno() {
		game.clear()
		self.configurarTorreDePuertas()
		self.configurarPersonajes()
		teclado.configurarTeclasPersonajes()
	}

	method iniciar() {
		self.setearFondo()
		menuInicial.iniciar()
		sonido.iniciar(sonidoDeFondo, true, 100)
	}

}

