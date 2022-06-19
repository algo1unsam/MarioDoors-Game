import wollok.game.*
import elementosVisibles.*
import torreDePuertas.*
import direcciones.*
import validaciones.*
import habilidades.*
import sonidos.*

class Personaje inherits ElementoMovible {

//	position = self.posicionInicial()
	const property oponente = null
	var property habilidades = []

	method nivelPlataformaInicial() = torreDePuertas.plataformasPorNivelPlataforma(1)
	
	method plataformaInicial() = self.nivelPlataformaInicial().anyOne()

	method posicionInicial() = self.plataformaInicial().position().up(1)

//	method validarPosicion(posicionSiguiente) {
//		mundo.validarPosicion(posicionSiguiente, self)
//	}
	override method mover(direccion) {
//		self.validarPosicionSiguiente(direccion)
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

	method noHayHabilidades() = habilidades.isEmpty()

	method primeraHabilidad() = habilidades.first()

	method agarrar(habilidad) {
		habilidades.add(habilidad)
		self.moverHabilidad()
	}

	method mostrarHabilidad() {
		if (not self.noHayHabilidades()) {
			self.primeraHabilidad().mostrar()
		}
	}

	method moverHabilidad() {
		if (not self.noHayHabilidades()) {
			self.primeraHabilidad().mover(direccionMovimiento, position)
		}
	}

	method limpiarHabilidad(habilidadAccionada) {
		game.removeVisual(habilidadAccionada)
		habilidades.remove(habilidadAccionada)
		self.mostrarHabilidad()
	}

	method accionarHabilidad() {
		if (self.noHayHabilidades()) {
			self.error('No hay habilitad para usar')
		}
		const habilidadAccionada = self.primeraHabilidad()
		habilidadAccionada.actuar(self)
		self.limpiarHabilidad(habilidadAccionada)
	}

}

object mario inherits Personaje(image = "mario_", direccionMovimiento = derecha, oponente = luigi, position = game.at(0, game.height() - 2)) {

	override method plataformaInicial() = self.nivelPlataformaInicial().first()

}

object luigi inherits Personaje(image = "luigi_", direccionMovimiento = izquierda, oponente = mario, position = game.at(game.width() - 1, game.height() - 2)) {

	override method plataformaInicial() = self.nivelPlataformaInicial().last()

}

