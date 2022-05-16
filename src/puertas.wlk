import wollok.game.*
import personajes.*

class Puerta {

	const property image = 'caja.png'
	var property position = game.at(0, 0)
	const property esPuerta = true
	var property positionDestino = game.at(0, 0)

	method trasladar(personaje) {
		personaje.position(positionDestino)
	}

}

class NivelPuertas {

	const property puertas = []
	const positionInicialPlataforma = game.at(1, 7) // Consultar a configuracion dificultad
	const cantidadPuertas = 6 // Consultar a configuracion dificultad

	method construirPuertas() {
		puertaFactory.positionInicialPlataforma(positionInicialPlataforma)
		cantidadPuertas.times({ i => puertas.add(puertaFactory.construirPuerta()) })
		puertas.forEach({ puerta => game.addVisual(puerta) })
	}

}

object puertaFactory {

	const espaciadoPuertas = 2
	var positionPuerta

	method positionInicialPlataforma(positionInicialPlataforma) {
		positionPuerta = positionInicialPlataforma.left(1).up(1)	
	}

	method positionXSiguiente() {
		positionPuerta = positionPuerta.right(espaciadoPuertas)
	}

	method positionPuerta() = positionPuerta

	method construirPuerta() {
		self.positionXSiguiente()
		return new Puerta(position = self.positionPuerta())
	}

}

