import wollok.game.*
import tablero.*
import menus.*
import dificultades.*
import personajes.*
import direcciones.*

object teclado {

	method configurarTeclasMenuInicial() {
			// Tecla Inicio Juego
		keyboard.space().onPressDo({ tablero.setearEntorno()})
			// Teclas Dificultades
		keyboard.num1().onPressDo({ menuInicial.seleccionar(dificultadUno)})
		keyboard.num2().onPressDo({ menuInicial.seleccionar(dificultadDos)})
	}

	method configurarTeclasMenuFinal() {
			// Tecla Menu Inicial
		keyboard.space().onPressDo({ tablero.setearMenuInicial()})
	}

	method configurarTeclasPersonajes() {
			// Teclas Izquierda
		keyboard.a().onPressDo{ mario.mover(izquierda)}
		keyboard.left().onPressDo{ luigi.mover(izquierda)}
			// Teclas Derecha
		keyboard.d().onPressDo{ mario.mover(derecha)}
		keyboard.right().onPressDo{ luigi.mover(derecha)}
			// Teclas Entrar Puerta
		keyboard.w().onPressDo{ mario.entrarPuerta()}
		keyboard.up().onPressDo{ luigi.entrarPuerta()}
			// Teclas de Accion
		keyboard.e().onPressDo{ mario.accionarHabilidad()}
		keyboard.control().onPressDo{ luigi.accionarHabilidad()}
	}

}

