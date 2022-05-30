import wollok.game.*
import torreDePuertas.*
import direcciones.*
import validaciones.*

class Personaje {

	const imagePersonaje
	var property position = self.positionInicial()
	var property direccionMovimiento
	var property velocidad = 1

	method image() = imagePersonaje + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method positionInicial() = self.plataformaInicial().position().up(1)

	method nivelPlataformaInicial() = torreDePuertas.nivelesPlataformas().first().plataformas()

	method plataformaInicial() = self.nivelPlataformaInicial().anyOne()

	method validarPosition(positionSiguiente) {
		mundo.validarPosition(positionSiguiente, self)
	}

	method mover(direccion) {
		const positionSiguiente = direccion.siguiente(position, velocidad)
		self.validarPosition(positionSiguiente)
		position = positionSiguiente
		direccionMovimiento = direccion
	}

	method salirPuerta() {
		direccionMovimiento = frente
	}

	method entrarPuerta() {
		const objetosMismaPosicion = self.position().allElements()
		objetosMismaPosicion.remove(self)
		if (not objetosMismaPosicion.any({ objeto => objeto.esPuerta()})) {
			self.error("No hay puerta para entrar")
		}
		const puerta = objetosMismaPosicion.find({ objeto => objeto.esPuerta() })
		puerta.trasladar(self)
		self.salirPuerta()
	}

}

object mario inherits Personaje(imagePersonaje = "mario_", direccionMovimiento = derecha) {

	override method plataformaInicial() = self.nivelPlataformaInicial().first()

}

object luigi inherits Personaje(imagePersonaje = "luigi_", direccionMovimiento = izquierda) {

	override method plataformaInicial() = self.nivelPlataformaInicial().last()

}

