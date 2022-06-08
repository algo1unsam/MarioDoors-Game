import wollok.game.*

class Antorcha {

	const property image = 'antorcha.png'
	var property position
	const property esPuerta = false

}

class Puerta {

	const imagenPuerta = 'puerta'
	var property estaAbierta = false
	var property position
	var property puertaDestino = null
	// var property positionDestino = game.at(0, 0)
	const property esPuerta = true

	method image() = imagenPuerta + self.imagenAbierta() + ".png"

	method imagenAbierta() = if (estaAbierta) {
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
		personaje.position(puertaDestino.position())
		puertaDestino.abrir()
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
	var posicionInicialPlataforma

	method cantidadPlataformas() = 15 // self.cantidadPuertas() * 2 + 1

	method cantidadPuertas() = if (not esNivelFinal) {
		7
	} else {
		1
	}

	method puertaSiguienteNivel() = torreDePuertas.siguienteNivel(self).puertas().anyOne()

	method puertaCualquierNivel() = torreDePuertas.cualquierNivel(self).puertas().anyOne()

	method puertaAnteriorNivel() = torreDePuertas.anteriorNivel(self).puertas().anyOne()

	method configurarPuertaDestinoSiguienteNivel() {
		puertas.anyOne().puertaDestino(self.puertaSiguienteNivel())
	}

	method configurarPuertaDestinoCualquierNivel() {
		puertas.anyOne().puertaDestino(self.puertaCualquierNivel())
	}

	method configurarPuertasDestinoDescendiente() {
		puertas.forEach({ puerta => puerta.puertaDestino(puertas.anyOne())}) // Seteo puertas destino en mismo nivel de plataformas
		self.configurarPuertaDestinoSiguienteNivel() // Seteo puerta destino al siguiente nivel de plataformas
	}

	method configurarPuertaFinal(puerta) {
		const puertaConPuertaDestinoFinal = self.puertaAnteriorNivel() // Seteo puerta final com puerta destino para una puerta del penultimo nivel
		puertaConPuertaDestinoFinal.puertaDestino(puerta)
	}

	method configurarPuertasDestinoAleatorio() {
		if (not esNivelFinal) {
			puertas.forEach({ puerta => puerta.puertaDestino(self.puertaCualquierNivel())})
		} else {
			puertas.forEach({ puerta =>
				puerta.puertaDestino(puerta)
			; self.configurarPuertaFinal(puerta)
			}) // Seteo puerta destino a si misma en el nivel de plataformas final
		}
	}

	method configurarPuertasDestino(seteoPuertasDestinoDescendiente) {
		if (seteoPuertasDestinoDescendiente) {
			self.configurarPuertasDestinoDescendiente()
		} else {
			self.configurarPuertasDestinoAleatorio()
		}
	}

	method construirAntorchas() {
		const plataformasPositionXPar = plataformas.filter({ plataforma => plataforma.position().x().even() })
		plataformasPositionXPar.forEach({ plataforma => antorchas.add(new Antorcha(position = plataforma.position().up(1)))})
	}

	method construirPuertas() {
		if (esNivelFinal) {
			const posicionPuerta = posicionInicialPlataforma.right(self.cantidadPlataformas() / 2 - 1)
			puertas.add(new Puerta(position = posicionPuerta.up(1)))
		} else {
			const plataformasPositionXImpar = plataformas.filter({ plataforma => plataforma.position().x().odd() })
			plataformasPositionXImpar.forEach({ plataforma => puertas.add(new Puerta(position = plataforma.position().up(1)))})
		}
	}

	method construirPlataforma() {
		plataformaFactory.posicionInicial(posicionInicialPlataforma)
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

	method posicionInicial(_posicionInicial) {
		position = _posicionInicial.left(2)
	}

	method posicionXSiguiente() {
		position = position.right(1)
	}

	method construirPlataforma() {
		self.posicionXSiguiente()
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
		return new NivelPlataforma(posicionInicialPlataforma = position, nroNivel = _nroNivel, esNivelFinal = _esNivelFinal)
	}

}

object torreDePuertas {

	var property cantidadNiveles = 4
	const property nivelesPlataformas = []
	var property seteoPuertasDestinoDescendiente = true

	method anteriorNivel(_nivelPlataforma) {
		const nroNivel = _nivelPlataforma.nroNivel()
		return nivelesPlataformas.find({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivel - 1 })
	}

	method siguienteNivel(_nivelPlataforma) {
		const nroNivel = _nivelPlataforma.nroNivel()
		return nivelesPlataformas.findOrDefault({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivel + 1 }, _nivelPlataforma) // Seteo puerta destino a en el siguiente nivel de plataformas o en el mismo nivel si es nivel final
	}

	method cualquierNivel(_nivelPlataforma) {
		const nroNivelAleatorio = (1 .. cantidadNiveles).anyOne() // Cualquier nivel de plataforma que no es nivel final
		return nivelesPlataformas.find({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivelAleatorio })
	}

	method agregarNivelPlataforma(nroNivel, esNivelFinal) {
		nivelesPlataformas.add(nivelPlataformaFactory.construirNivelPlataforma(nroNivel, esNivelFinal))
	}

	method construirTorreDePuertas() {
		var esNivelFinal = false
		cantidadNiveles.times({ nroNivel => self.agregarNivelPlataforma(nroNivel, esNivelFinal)})
		esNivelFinal = true
		self.agregarNivelPlataforma(cantidadNiveles + 1, esNivelFinal)
//		var esNivelFinal = false
//		cantidadNiveles.times({ nroNivel => nivelesPlataformas.add(nivelPlataformaFactory.construirNivelPlataforma(nroNivel, esNivelFinal))})
//		esNivelFinal = true
//		nivelesPlataformas.add(nivelPlataformaFactory.construirNivelPlataforma(cantidadNiveles + 1, esNivelFinal))
	}

	method agregarAlTablero() {
		self.construirTorreDePuertas()
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.agregarAlTablero()})
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.configurarPuertasDestino(seteoPuertasDestinoDescendiente)})
	}

}

