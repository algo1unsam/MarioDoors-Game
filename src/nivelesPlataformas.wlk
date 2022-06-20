import wollok.game.*
import torreDePuertas.*
import plataformas.*
import puertas.*
import antorchas.*
import habilidades.*

class NivelPlataforma {

	const property nroNivel = 0
	const esNivelFinal
	const cantidadPlataformas = 15
	const property plataformas = []
	const property puertas = []
	const property antorchas = []
	var posicionInicialPlataforma

	method cantidadPuertas() = if (not esNivelFinal) 7 else 1

	method puertaSiguienteNivel() = torreDePuertas.siguienteNivelPlataforma(self).puertas().anyOne()

	method puertaCualquierNivel() = torreDePuertas.cualquierNivelPlataforma(self).puertas().anyOne()

	method puertaAnteriorNivel() = torreDePuertas.anteriorNivelPlataforma(self).puertas().anyOne()

	method configurarPuertaDestinoSiguienteNivel() {
		puertas.anyOne().puertaDestino(self.puertaSiguienteNivel())
	}

	method configurarPuertasDestinoSegunDificultad(dificultadDescendiente) {
		if (dificultadDescendiente) {
			puertas.forEach({ puerta => puerta.puertaDestino(puertas.anyOne())}) // Seteo puertas destino en mismo nivel de plataformas
			self.configurarPuertaDestinoSiguienteNivel() // Seteo de una puerta destino al siguiente nivel de plataformas
		} else {
			puertas.forEach({ puerta => puerta.puertaDestino(self.puertaCualquierNivel())})
		}
	}

	method configurarPuertaFinal() {
		const puertaFinal = puertas.uniqueElement()
		const puertaAnteriorNivel = self.puertaAnteriorNivel()
		puertaAnteriorNivel.puertaDestino(puertaFinal)
		puertaFinal.puertaOrigen(puertaAnteriorNivel)
	// puertaFinal.puertaDestino(puertaFinal)
	}

	method configurarPuertasDestino(dificultadDescendiente) {
		if (not esNivelFinal) {
			self.configurarPuertasDestinoSegunDificultad(dificultadDescendiente)
		} else {
			self.configurarPuertaFinal()
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

	method agregarHabilidades() {
		if (not esNivelFinal) {
			const cantidadHabilidades = (0 .. 2).anyOne()
			cantidadHabilidades.times({ i => generadorHabilidades.agregarAlTablero(plataformas.anyOne().position().up(1))})
		}
	}

	method mostrar(elementos) {
		elementos.forEach({ elemento => elemento.mostrar()})
	}

	method agregarAlTablero() {
		self.construirPlataforma()
		self.mostrar(plataformas)
		self.mostrar(puertas)
		self.mostrar(antorchas)
		self.agregarHabilidades()
	}

}

object nivelPlataformaFactory {

	const posicionInicial = game.at(0, game.height())
	var property position

	method seteoInicial() {
		position = posicionInicial
	}

	method espacioEntreNivelesPlataformas(esNivelFinal) = if (esNivelFinal) 4 else 3

	method posicionYSiguiente(esNivelFinal) {
		position = position.down(self.espacioEntreNivelesPlataformas(esNivelFinal))
	}

	method construirNivelPlataforma(_nroNivel, _esNivelFinal) {
		self.posicionYSiguiente(_esNivelFinal)
		return new NivelPlataforma(posicionInicialPlataforma = position, nroNivel = _nroNivel, esNivelFinal = _esNivelFinal)
	}

}

