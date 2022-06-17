import nivelesPlataformas.*

object torreDePuertas {

	var property cantidadNiveles = 4
	const property nivelesPlataformas = []
	var property seteoPuertasDestinoDescendiente = true

	method puertaFinal() = nivelesPlataformas.last().puertas().uniqueElement()

	method puertaQueLlevaPuertaFinal() = self.puertaFinal().puertaOrigen()

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
	}

	method agregarAlTablero() {
		self.construirTorreDePuertas()
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.agregarAlTablero()})
		nivelesPlataformas.forEach({ nivelPlataforma => nivelPlataforma.configurarPuertasDestino(seteoPuertasDestinoDescendiente)})
	}

}

