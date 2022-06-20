import wollok.game.*
import menus.*
import torreDePuertas.*
import personajes.*
import teclado.*
import sonidos.*
import habilidades.*
import direcciones.*

object tablero {

	const sonidoDeFondo = "sonidoDeFondo.mp3"
	var partidas = 0

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
//		mario.velocidad(1)
//		luigi.velocidad(1)
//		mario.mostrar()
//		self.setearColisiones(mario)
//		luigi.mostrar()
//		self.setearColisiones(luigi)
		if (partidas > 0) {
			game.removeVisual(mario)
			game.removeVisual(luigi)
//			mario.position(game.at(0, game.height() - 2))
//			luigi.position(game.at(game.width() - 1, game.height() - 2))
			mario.image("mario_")
			luigi.image("luigi_")
			mario.direccionMovimiento(derecha)
			luigi.direccionMovimiento(izquierda)
			mario.position(game.at(0, 0))
			luigi.position(game.at(0, 0))
		}
		game.addVisual(mario)
		game.addVisual(luigi)
		if (game.hasVisual(mario)) {
			game.say(mario, "Estoy en el tablero")
		}
	}

	method setearEntorno() {
		game.clear()
		generadorHabilidades.limpiarHabilidadesEnElTablero()
		self.configurarTorreDePuertas()
		self.configurarPersonajes()
		teclado.configurarTeclasPersonajes()
	}

	method pausarPersonajes() {
		mario.velocidad(0)
		luigi.velocidad(0)
	}

	method finalizarPartida() {
//		self.pausarPersonajes()
		partidas += 1
		game.schedule(1000, { game.clear()
		; menuFinal.iniciar()
		})
	}

}

