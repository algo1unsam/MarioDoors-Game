import nivelesPlataformas.*
import habilidades.*

object torreDePuertas {

	var property cantidadNiveles = 4
	const property nivelesPlataformas = []
	var property dificultadDescendiente = true

	method puertaFinal() = nivelesPlataformas.last().puertas().uniqueElement()

	method puertaQueLlevaPuertaFinal() = self.puertaFinal().puertaOrigen()

	method anteriorNivelPlataforma(_nivelPlataforma) {
		const nroNivel = _nivelPlataforma.nroNivel()
		return nivelesPlataformas.find({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivel - 1 })
	}

	method siguienteNivelPlataforma(_nivelPlataforma) {
		const nroNivel = _nivelPlataforma.nroNivel()
		return nivelesPlataformas.find({ nivelPlataforma => nivelPlataforma.nroNivel() == nroNivel + 1 }) // Seteo puerta destino a en el siguiente nivel de plataformas
	}

	method cualquierNivelPlataforma(_nivelPlataforma) {
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
	}

	method limpiarNivelesPlataformas() {
		nivelesPlataformas.clear()
		nivelPlataformaFactory.seteoInicial()
	}

	method agregarAlTablero() {
		generadorHabilidades.seteoInicial()
		self.limpiarNivelesPlataformas()
		self.construirTorreDePuertas()
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.agregarAlTablero()})
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.configurarPuertasDestino(dificultadDescendiente)})
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.agregarHabilidades()})
	}

}

