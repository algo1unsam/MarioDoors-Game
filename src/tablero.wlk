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
		game.height(20)
		game.ground("fondo_negro.png")
	}
	method agregarTorreDePuertas() {
		torreDePuertas.agregarAlTablero()
	}

	method agregarPersonajes() {
		game.addVisual(mario)
		mario.mostrarHabilidad()
		game.addVisual(luigi)
		luigi.mostrarHabilidad()
	}

	method setearEntorno() {
		game.clear()
		self.agregarTorreDePuertas()
		self.agregarPersonajes()
		teclado.configurarTeclasPersonajes()
	}

	method iniciar() {
		self.setearFondo()
		menuInicial.iniciar()
		sonido.iniciar(sonidoDeFondo,true,200)
	}
	

}

