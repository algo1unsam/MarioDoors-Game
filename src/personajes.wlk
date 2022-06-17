import wollok.game.*
import torreDePuertas.*
import direcciones.*
import validaciones.*
import habilidades.*
import sonidos.*

class Personaje {

	const imagePersonaje
	var property position = self.posicionInicial()
	var property direccionMovimiento
	var property velocidad = 1
	const property oponente = null
	var property cambioDireccion = false
	var property habilidades = []
	const property esPuerta = false

	method image() = imagePersonaje + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method nivelPlataformaInicial() = torreDePuertas.nivelesPlataformas().first().plataformas()

	method plataformaInicial() = self.nivelPlataformaInicial().anyOne()

	method posicionInicial() = self.plataformaInicial().position().up(1)

	method validarPosicion(posicionSiguiente) {
		mundo.validarPosicion(posicionSiguiente, self)
	}

	method mover(direccion) {
		const posicionSiguiente = direccion.siguiente(position, velocidad, cambioDireccion)
		self.validarPosicion(posicionSiguiente)
		position = posicionSiguiente
		direccionMovimiento = direccion
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

	method moverHabilidad() {
		if (not self.noHayHabilidades()) {
			self.primeraHabilidad().mover(direccionMovimiento, position)
		}
	}

	method agarrar(habilidad) {
		habilidades.add(habilidad)
		self.moverHabilidad()
	}

	method mostrarHabilidad() {
		if (not self.noHayHabilidades()) {
			game.addVisual(self.primeraHabilidad())
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

object mario inherits Personaje(imagePersonaje = "mario_", direccionMovimiento = derecha, oponente = luigi, habilidades = [ llavePuertaFinal, freezearAlOponente ]) {

	override method plataformaInicial() = self.nivelPlataformaInicial().first()

}

object luigi inherits Personaje(imagePersonaje = "luigi_", direccionMovimiento = izquierda, oponente = mario, habilidades = [ ayudaPuertaFinal, cambiadorDeTeclas ]) {

	override method plataformaInicial() = self.nivelPlataformaInicial().last()

}

