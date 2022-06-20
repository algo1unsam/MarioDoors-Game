import wollok.game.*
import elementosVisibles.*
import torreDePuertas.*
import direcciones.*
import habilidades.*
import sonidos.*

class Personaje inherits ElementoMovible {

	const property oponente = null
	var property habilidad = null

	override method mover(direccion) {
		super(direccion)
		self.moverHabilidad()
	}

	method puertaMismaPosicion() {
		const objetosMismaPosicion = self.position().allElements()
		objetosMismaPosicion.remove(self)
		if (not objetosMismaPosicion.any({ objeto => objeto.esPuerta()})) {
			self.error("No hay puerta para entrar")
		}
		return objetosMismaPosicion.find({ objeto => objeto.esPuerta() })
	}

	method salirPuerta() {
		direccionMovimiento = frente
		self.moverHabilidad()
	}

	method entrarPuerta() {
		const puerta = self.puertaMismaPosicion()
		puerta.trasladar(self)
		self.salirPuerta()
	}

	method noHayHabilidad() = habilidad == null

	method agarrar(_habilidad) {
		if (self.noHayHabilidad()) {
			habilidad = _habilidad
		}
	}

	method moverHabilidad() {
		if (not self.noHayHabilidad()) {
			habilidad.mover(direccionMovimiento, position)
		}
	}

	method limpiarHabilidad() {
		habilidad.remover()
		habilidad = null
	}

	method accionarHabilidad() {
		if (self.noHayHabilidad()) {
			self.error('No hay habilitad para usar')
		}
		habilidad.actuar(self)
		self.limpiarHabilidad()
	}

}

object mario inherits Personaje(image = "mario_", direccionMovimiento = derecha, oponente = luigi, position = game.at(0, game.height() - 2)) {

}

object luigi inherits Personaje(image = "luigi_", direccionMovimiento = izquierda, oponente = mario, position = game.at(game.width() - 1, game.height() - 2)) {

}

