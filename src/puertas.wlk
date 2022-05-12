import wollok.game.*
import personajes.*

class Puerta{
	
	const property image = 'caja.png'
	var property position = game.at(0,0)
	const property esPuerta = true
	var property positionDestino = game.at(0,0)
	
	method trasladar(personaje) {
		personaje.position(positionDestino)
	}

}
