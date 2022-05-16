import wollok.game.*
import escenarios.*

class Puerta {

	const property image = 'caja.png'
	var property position = game.at(0, 0)
	const property esPuerta = true
	var property positionDestino = game.at(0, 0)

	method trasladar(personaje) {
		personaje.position(positionDestino)
	}

}

class Plataforma {

	const property image = 'muro.png'
	var property position = game.at(0, 0)
	const property esPlataforma = true

}

class NivelPlataforma {

	const property plataformas = []
	const puertas = []
	var positionInicialPlataforma // = game.at(1, 7) // Consultar a configuracion dificultad
	// const cantidadPuertas = 6 // Consultar a configuracion dificultad
	const cantidadPlataformas = 13

	method construirPlataforma() {
		plataformaFactory.positionInicialPlataforma(positionInicialPlataforma)
		cantidadPlataformas.times({ i => plataformas.add(plataformaFactory.construirPlataforma())})
		self.construirPuertas()
	}

	method construirPuertas() {
		const plataformasPositionXPar = plataformas.filter({ plataforma => plataforma.position().x().even() })
		plataformasPositionXPar.forEach({ plataforma => puertas.add(new Puerta(position = plataforma.position().up(1)))})
	}

	method agregarAlTablero() {
		self.construirPlataforma()
		plataformas.forEach({ plataforma => game.addVisual(plataforma)})
		puertas.forEach({ puerta => game.addVisual(puerta)})
	}

}

object plataformaFactory {

	var position

	method positionInicialPlataforma(positionInicialPlataforma) {
		position = positionInicialPlataforma.left(1)
	}

	method positionXSiguiente() {
		position = position.right(1)
	}

	method construirPlataforma() {
		self.positionXSiguiente()
		return new Plataforma(position = position)
	}

}

