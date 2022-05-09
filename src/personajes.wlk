import wollok.game.*
import direccionesMovimiento.*

class Personaje {

	const property image
	var property position = game.at(0, 0)
	var property velocidad = 1

	method mover(direccion) {
		const positionSiguiente = direccion.siguiente(position, velocidad)
		position = positionSiguiente
	}

}

object mario inherits Personaje(image = "jugador1.png", position = game.at(0, 0)) {

}

object luigi inherits Personaje(image = "jugador2.png", position = game.at(9, 0)) {

}

