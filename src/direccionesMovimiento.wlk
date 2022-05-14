import wollok.game.*
import personajes.*


object arriba {

	method siguiente(positionActual, velocidad) = positionActual.up(velocidad)

}

object abajo {

	method siguiente(positionActual, velocidad) = positionActual.down(velocidad)

}

object izquierda {

	method siguiente(positionActual, velocidad) = positionActual.left(velocidad)

}

object derecha {

	method siguiente(positionActual, velocidad) = positionActual.right(velocidad)

}


