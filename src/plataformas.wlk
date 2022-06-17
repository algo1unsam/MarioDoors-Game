class Plataforma {

	const property image = 'plataforma.png'
	var property position

}

object plataformaFactory {

	var position

	method posicionInicial(_posicionInicial) {
		position = _posicionInicial.left(1)
	}

	method posicionXSiguiente() {
		position = position.right(1)
	}

	method construirPlataforma() {
		self.posicionXSiguiente()
		return new Plataforma(position = position)
	}

}

