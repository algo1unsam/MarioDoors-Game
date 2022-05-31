import wollok.game.*

class Puerta {

	const property image = 'puerta.png'
	var property position
	const property esPuerta = true
	var property positionDestino = game.at(0, 0)

	method trasladar(personaje) {
		personaje.position(positionDestino)
	}

}

class Plataforma {

	const property image = 'plataforma.png'
	var property position
	const property esPlataforma = true

}

class NivelPlataforma {

	const property nroNivel = 0
	const esNivelFinal = false
	const property plataformas = []
	const property puertas = []
	var positionInicialPlataforma

	method cantidadPlataformas() = self.cantidadPuertas() * 2 + 1

	method cantidadPuertas() = if (not esNivelFinal) {
		7
	} else {
		1
	}

	method puertaSiguienteNivel() = torreDePuertas.siguienteNivel(self).puertas().anyOne()

	method positionSiguienteNivel() = self.puertaSiguienteNivel().position()

	method configurarPuertasPositionDestino() {
		const positionsDestino = puertas.map({ puerta => puerta.position() })
		const positionSiguienteNivel = self.positionSiguienteNivel()
		puertas.forEach({ puerta => puerta.positionDestino(positionsDestino.anyOne())})
		puertas.anyOne().positionDestino(positionSiguienteNivel)
	}

	method construirPuertas() {
		const plataformasPositionXImpar = plataformas.filter({ plataforma => plataforma.position().x().odd() })
		plataformasPositionXImpar.forEach({ plataforma => puertas.add(new Puerta(position = plataforma.position().up(1)))})
	}

	method construirPlataforma() {
		plataformaFactory.positionInicial(positionInicialPlataforma)
		self.cantidadPlataformas().times({ i => plataformas.add(plataformaFactory.construirPlataforma())})
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
		position = _positionInicial.left(2)
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
		position = position.down(4) // Espacio entre nivel plataformas
	}

	method construirNivelPlataforma(_nroNivel, _esNivelFinal) {
		self.positionYSiguiente()
		return new NivelPlataforma(positionInicialPlataforma = position, nroNivel = _nroNivel, esNivelFinal = _esNivelFinal)
	}

}

object torreDePuertas {

	var property cantidadNiveles = 3
	const positionInicialPlataforma = game.at(1, game.height())
	const property nivelesPlataformas = []

	method siguienteNivel(_nivelPlataforma) {
		const nroNivel = _nivelPlataforma.nroNivel()
		return nivelesPlataformas.findOrDefault({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivel + 1 }, _nivelPlataforma)
	}

	method construirTorreDePuertas() {
		var esNivelFinal = false
		nivelPlataformaFactory.positionInicial(positionInicialPlataforma)
		cantidadNiveles.times({ nroNivel => nivelesPlataformas.add(nivelPlataformaFactory.construirNivelPlataforma(nroNivel, esNivelFinal))})
		esNivelFinal = true
		nivelesPlataformas.add(nivelPlataformaFactory.construirNivelPlataforma(cantidadNiveles + 1, esNivelFinal))
	}

	method agregarAlTablero() {
		self.construirTorreDePuertas()
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.agregarAlTablero()})
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.configurarPuertasPositionDestino()})
	}

}

