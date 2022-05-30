import wollok.game.*
import personajes.*

object mundo {

	method validarPosition(proximaPosition, personaje) {
		if (not proximaPosition.x().between(0, game.width() - 1)) {
			personaje.error("Posicion fuera de ancho")
		}
	}

}

