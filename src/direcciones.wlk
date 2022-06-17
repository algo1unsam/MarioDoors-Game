import wollok.game.*
import personajes.*

class Direccion {

	method siguiente(positionActual, velocidad)

	method siguiente(positionActual, velocidad, cambioDireccion)

}

object frente inherits Direccion {
	override method siguiente(positionActual, velocidad) = positionActual

	override method siguiente(positionActual, velocidad, cambioDireccion) = positionActual
}

object izquierda inherits Direccion {

	override method siguiente(positionActual, velocidad) {
		return positionActual.left(velocidad)
	}

	override method siguiente(positionActual, velocidad, cambioDireccion) {
		var direccionSiguiente = self
		if (cambioDireccion) {
			direccionSiguiente = derecha
		}
		return direccionSiguiente.siguiente(positionActual, velocidad)
	}

}

object derecha inherits Direccion {

	override method siguiente(positionActual, velocidad) {
		return positionActual.right(velocidad)
	}

	override method siguiente(positionActual, velocidad, cambioDireccion) {
		var direccionSiguiente = self
		if (cambioDireccion) {
			direccionSiguiente = izquierda
		}
		return direccionSiguiente.siguiente(positionActual, velocidad)
	}

}

