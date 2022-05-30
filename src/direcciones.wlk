import wollok.game.*
import personajes.*

class Direccion {
	method siguiente(positionActual, velocidad) = positionActual
}

object frente inherits Direccion {
	
}

object izquierda inherits Direccion {

	override method siguiente(positionActual, velocidad) = positionActual.left(velocidad)

}

object derecha inherits Direccion {

	override method siguiente(positionActual, velocidad) = positionActual.right(velocidad)

}



