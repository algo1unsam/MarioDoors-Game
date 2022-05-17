import wollok.game.*
import escenarios.*

class Puerta {

	const property image = 'caja.png'
	var property position
	const property esPuerta = true
	var property positionDestino = game.at(0, 0)

	method trasladar(personaje) {
		personaje.position(positionDestino)
	}

}

class Plataforma {

	const property image = 'muro.png'
	var property position
	const property esPlataforma = true

}

class NivelPlataforma {

	const property plataformas = []
	const puertas = []
	var positionInicialPlataforma
	const cantidadPuertas = 6 // Consultar a configuracion dificultad
	const cantidadPlataformas = cantidadPuertas * 2 + 1

	method configurarPuertasPositionDestino() {
		const positionsDestino = puertas.map({ puerta => puerta.position() })
		puertas.forEach({ puerta => puerta.positionDestino(positionsDestino.anyOne())})
	}

	method construirPuertas() {
		const plataformasPositionXPar = plataformas.filter({ plataforma => plataforma.position().x().even() })
		plataformasPositionXPar.forEach({ plataforma => puertas.add(new Puerta(position = plataforma.position().up(1)))})
		self.configurarPuertasPositionDestino()
	}

	method construirPlataforma() {
		plataformaFactory.positionInicial(positionInicialPlataforma)
		cantidadPlataformas.times({ i => plataformas.add(plataformaFactory.construirPlataforma())})
		self.construirPuertas()
	}

	method agregarAlTablero() {
		self.construirPlataforma()
		plataformas.forEach({ plataforma => game.addVisual(plataforma)})
		puertas.forEach({ puerta => game.addVisual(puerta)})
	}

}

object plataformaFactory {

	var position

	method positionInicial(_positionInicial) {
		position = _positionInicial.left(1)
	}

	method positionXSiguiente() {
		position = position.right(1)
	}

	method construirPlataforma() {
		self.positionXSiguiente()
		return new Plataforma(position = position)
	}

}

object nivelPlataformaFactory {

	var position

	method positionInicial(_positionInicial) {
		position = _positionInicial
	}

	method positionYSiguiente() {
		position = position.down(3)
	}

	method construirNivelPlataforma() {
		self.positionYSiguiente()
		return new NivelPlataforma(positionInicialPlataforma = position)
	}

}

object torreDePuertas {

	const cantidadNiveles = 3
	const positionInicialPlataforma = game.at(1, game.height()) // game.at(2,9)
	const property nivelesPlataformas = []

	method construirTorreDePuertas() {
		nivelPlataformaFactory.positionInicial(positionInicialPlataforma)
		cantidadNiveles.times({ i => nivelesPlataformas.add(nivelPlataformaFactory.construirNivelPlataforma())})
	}

	method agregarAlTablero() {
		self.construirTorreDePuertas()
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.agregarAlTablero()})
	}

}

