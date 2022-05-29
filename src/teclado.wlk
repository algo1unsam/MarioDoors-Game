import wollok.game.*
import personajes.*
import direccionesMovimiento.*

object teclado {

	method configurarTeclas() {
		// Teclas Izquierda
		keyboard.a().onPressDo{ mario.mover(izquierda)}
		keyboard.left().onPressDo{ luigi.mover(izquierda)}
		// Teclas Derecha
		keyboard.d().onPressDo{ mario.mover(derecha)}
		keyboard.right().onPressDo{ luigi.mover(derecha)}
		// Teclas Entrar Puerta
		keyboard.w().onPressDo{ mario.entrarPuerta()}
		keyboard.up().onPressDo{ luigi.entrarPuerta()}
	}

}

