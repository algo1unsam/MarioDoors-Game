import wollok.game.*
import sonidos.*
import menus.*
import torreDePuertas.*
import personajes.*
import teclado.*

object tablero {

	const sonidoDeFondo = "sonidoDeFondo.mp3"
	const personajes = #{ mario, luigi }

	method setearFondo() {
		game.title("Mario Doors Game")
		game.cellSize(80)
		game.width(15)
		game.height(16)
		game.ground("fondo_negro.png")
	}

	method setearMenuInicial() {
		game.clear()
		menuInicial.iniciar()
	}

	method iniciar() {
		self.setearFondo()
		self.setearMenuInicial()
		sonido.iniciar(sonidoDeFondo, true, 100)
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
		personajes.forEach({ personaje =>
			personaje.seteoInicial()
		;
			personaje.mostrar()
		; self.setearColisiones(personaje)
		})
	}

	method setearEntorno() {
		game.clear()
		self.configurarTorreDePuertas()
		self.configurarPersonajes()
		teclado.configurarTeclasPersonajes()
	}

	method pausarPersonajes() {
		personajes.forEach({ personaje => personaje.velocidad(0)})
	}

	method finalizarPartida() {
		self.pausarPersonajes()
		game.schedule(1000, { menuFinal.iniciar()})
	}

}

