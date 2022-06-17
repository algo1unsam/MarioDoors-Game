import wollok.game.*
import personajes.*

object mundo {

	method validarPosicion(posicionSiguiente, personaje) {
		if (not posicionSiguiente.x().between(0, game.width() - 1)) {
			personaje.error("Posicion fuera de ancho")
		}
	}

}

