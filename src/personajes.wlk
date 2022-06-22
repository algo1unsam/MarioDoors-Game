import wollok.game.*
import elementosVisibles.*
import torreDePuertas.*
import direcciones.*
import habilidades.*
import sonidos.*

class Personaje inherits ElementoMovible {

	const property oponente = null
	var property habilidad = null
	const posicionInicial
	const direccionMovimientoInicial

	override method seteoInicial() {
		position = posicionInicial
		velocidad = 1
		direccionMovimiento = direccionMovimientoInicial
		habilidad = null
		cambioDireccion = false
	}

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

	method removerHabilidadEnElTablero() {
		if (game.hasVisual(habilidad)) {
			habilidad.remover()
		}
	}

	method limpiarHabilidad() {
		if (not self.noHayHabilidad()) {
			self.removerHabilidadEnElTablero()
			habilidad = null
		}
	}

	method validarAccionarHabilidad() {
		if (self.noHayHabilidad()) {
			self.error('No hay habilidad para usar')
		}
	}

	method accionarHabilidad() {
		self.validarAccionarHabilidad()
		habilidad.actuar(self)
		self.limpiarHabilidad()
	}

	method pausar() {
		velocidad = 0
		self.limpiarHabilidad()
	}

}

object mario inherits Personaje(image = "mario_", direccionMovimientoInicial = derecha, oponente = luigi, posicionInicial = game.at(0, 14)) {

}

object luigi inherits Personaje(image = "luigi_", direccionMovimientoInicial = izquierda, oponente = mario, posicionInicial = game.at(14, 14)) {

}

