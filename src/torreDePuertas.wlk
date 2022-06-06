import wollok.game.*

class Antorcha {

	const property image = 'antorcha.png'
	var property position
	const property esPuerta = false

}

class Puerta {

	const imagePuerta = 'puerta'
	var property estaAbierta = false
	var property position
	var property positionDestino = game.at(0, 0)
	const property esPuerta = true

	method image() = imagePuerta + self.imageAbierta() + ".png"

	method imageAbierta() = if (estaAbierta) {
		"_abierta"
	} else {
		""
	}

	method abrir() {
		estaAbierta = true
		game.schedule(1000, { estaAbierta = false})
	}

	method trasladar(personaje) {
		self.abrir()
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
	const property antorchas = []
	var positionInicialPlataforma

	method cantidadPlataformas() = 15 // self.cantidadPuertas() * 2 + 1

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

	method construirAntorchas() {
		const plataformasPositionXPar = plataformas.filter({ plataforma => plataforma.position().x().even() })
		plataformasPositionXPar.forEach({ plataforma => antorchas.add(new Antorcha(position = plataforma.position().up(1)))})
	}

	method construirPuertas() {
		if (esNivelFinal) {
			const positionPuerta = positionInicialPlataforma.right(self.cantidadPlataformas()/2 - 1)
			puertas.add(new Puerta(position = positionPuerta.up(1)))
		} else {
			const plataformasPositionXImpar = plataformas.filter({ plataforma => plataforma.position().x().odd() })
			plataformasPositionXImpar.forEach({ plataforma => puertas.add(new Puerta(position = plataforma.position().up(1)))})
		}
	}

	method construirPlataforma() {
		plataformaFactory.positionInicial(positionInicialPlataforma)
		self.cantidadPlataformas().times({ i => plataformas.add(plataformaFactory.construirPlataforma())})
		self.construirPuertas()
		self.construirAntorchas()
	}

	method agregarAlTablero() {
		self.construirPlataforma()
		plataformas.forEach({ plataforma => game.addVisual(plataforma)})
		puertas.forEach({ puerta => game.addVisual(puerta)})
		antorchas.forEach({ antorcha => game.addVisual(antorcha)})
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

	var position = game.at(1, game.height())

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
	const property nivelesPlataformas = []

	method siguienteNivel(_nivelPlataforma) {
		const nroNivel = _nivelPlataforma.nroNivel()
		return nivelesPlataformas.findOrDefault({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivel + 1 }, _nivelPlataforma)
	}

	method construirTorreDePuertas() {
		var esNivelFinal = false
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

