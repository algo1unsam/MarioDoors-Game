import wollok.game.*
import direcciones.*

class ElementoVisible {

	var property image
	var property position

	method mostrar() = game.addVisual(self)

	method remover() = game.removeVisual(self)

}

class ElementoMovible inherits ElementoVisible(position = game.origin()) {

	const velocidad = 1
	const cambioDireccion = false
	var direccionMovimiento = frente

	override method image() = image + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method posicionSiguiente(direccion) = direccion.siguiente(position, velocidad, cambioDireccion)

	method posicionSiguienteValidada(direccion) {
		var posicionSiguiente = self.posicionSiguiente(direccion)
		if (not posicionSiguiente.x().between(0, game.width() - 1)) {
			posicionSiguiente = position
		}
		return posicionSiguiente
	}

	method mover(direccion) {
		position = self.posicionSiguienteValidada(direccion)
		direccionMovimiento = direccion
	}

}

