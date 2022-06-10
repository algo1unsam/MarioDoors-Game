import wollok.game.*
import menuInicial.*
import torreDePuertas.*
import personajes.*
import teclado.*
import sonidos.*

object tablero {

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
		game.addVisual(mario.habilidad())
		game.addVisual(luigi)
		game.addVisual(luigi.habilidad())
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
		musica.fondo()
	}
	

}

