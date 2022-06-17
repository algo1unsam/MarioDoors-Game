import wollok.game.*
import torreDePuertas.*
import plataformas.*
import puertas.*
import antorchas.*

class NivelPlataforma {

	const property nroNivel = 0
	const esNivelFinal
	const cantidadPlataformas = 15
	const property plataformas = []
	const property puertas = []
	const property antorchas = []
	var posicionInicialPlataforma

	method cantidadPuertas() = if (not esNivelFinal) 7 else 1

	// method puertaQueLlevaPuertaFinal() = puertas.find({ puerta => puerta.puertaDestino().esPuertaFinal() }).uniqueElement()
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
		if (not esNivelFinal) {
			puertas.forEach({ puerta => puerta.puertaDestino(puertas.anyOne())}) // Seteo puertas destino en mismo nivel de plataformas
			self.configurarPuertaDestinoSiguienteNivel() // Seteo puerta destino al siguiente nivel de plataformas
		} else {
			self.configurarPuertaFinal() // Seteo puerta destino a si misma en el nivel de plataformas final
		}
	}

	method configurarPuertaFinal() {
		const puertaFinal =puertas.uniqueElement()
		const puertaAnteriorNivel = self.puertaAnteriorNivel() // Seteo puerta final con puerta destino para una puerta del penultimo nivel
		puertaAnteriorNivel.puertaDestino(puertaFinal)
		puertaFinal.puertaOrigen(puertaAnteriorNivel)
	}

	method configurarPuertasDestinoAleatorio() {
		if (not esNivelFinal) {
			puertas.forEach({ puerta => puerta.puertaDestino(self.puertaCualquierNivel())})
		} else {
			self.configurarPuertaFinal() // Seteo puerta destino a si misma en el nivel de plataformas final
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
			const posicionPlataformaCentral = posicionInicialPlataforma.right(cantidadPlataformas / 2)
			puertas.add(new PuertaFinal(position = posicionPlataformaCentral.up(1)))
		} else {
			const plataformasPositionXImpar = plataformas.filter({ plataforma => plataforma.position().x().odd() })
			plataformasPositionXImpar.forEach({ plataforma => puertas.add(new Puerta(position = plataforma.position().up(1)))})
		}
	}

	method construirPlataforma() {
		plataformaFactory.posicionInicial(posicionInicialPlataforma)
		cantidadPlataformas.times({ i => plataformas.add(plataformaFactory.construirPlataforma())})
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

object nivelPlataformaFactory {

	var position = game.at(0, game.height())

	method positionYSiguiente() {
		position = position.down(4) // Espacio entre nivel plataformas
	}

	method construirNivelPlataforma(_nroNivel, _esNivelFinal) {
		self.positionYSiguiente()
		return new NivelPlataforma(posicionInicialPlataforma = position, nroNivel = _nroNivel, esNivelFinal = _esNivelFinal)
	}

}

