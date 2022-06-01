import wollok.game.*
import torreDePuertas.*
import direcciones.*
import validaciones.*
import habilidades.*

class Personaje {

	const imagePersonaje
	var property position = self.positionInicial()
	var property direccionMovimiento
	var property velocidad = 1
	const property oponente = null
	var property cambioDireccion = false
	var property habilidad = null

	method image() = imagePersonaje + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method positionInicial() = self.plataformaInicial().position().up(1)

	method nivelPlataformaInicial() = torreDePuertas.nivelesPlataformas().first().plataformas()

	method plataformaInicial() = self.nivelPlataformaInicial().anyOne()

	method validarPosition(positionSiguiente) {
		mundo.validarPosition(positionSiguiente, self)
	}

	method moverHabilidad() {
		if (habilidad != null) {
			habilidad.position(self.position().up(2))
		}
	}

	method mover(direccion) {
		const positionSiguiente = direccion.siguiente(position, velocidad, cambioDireccion)
		self.validarPosition(positionSiguiente)
		position = positionSiguiente
		self.moverHabilidad()
		direccionMovimiento = direccion
	}

	method salirPuerta() {
		direccionMovimiento = frente
		self.moverHabilidad()
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

	method agarrar(_habilidad) {
		habilidad = _habilidad
		self.moverHabilidad()
	}

	method limpiarHabilidad() {
		game.removeVisual(habilidad)
		habilidad = null
	}

	method accionarHabilidad() {
		if (habilidad == null) {
			self.error('No hay habilitad para usar')
		}
		habilidad.actuar(self)
		self.limpiarHabilidad()
	}

}

object mario inherits Personaje(imagePersonaje = "mario_", direccionMovimiento = derecha, oponente = luigi, habilidad = cambiadorDeTeclas) {

	override method plataformaInicial() = self.nivelPlataformaInicial().first()

}

object luigi inherits Personaje(imagePersonaje = "luigi_", direccionMovimiento = izquierda, oponente = mario, habilidad = freezearAlOponente) {

	override method plataformaInicial() = self.nivelPlataformaInicial().last()

}

