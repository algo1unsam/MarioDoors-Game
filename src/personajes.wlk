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
	var property habilidad = #{}
	const property esPuerta = false

	method image() = imagePersonaje + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method nivelPlataformaInicial() = torreDePuertas.nivelesPlataformas().first().plataformas()

	method plataformaInicial() = self.nivelPlataformaInicial().anyOne()

	method posicionInicial() = self.plataformaInicial().position().up(1)

	method validarPosition(positionSiguiente) {
		mundo.validarPosition(positionSiguiente, self)
	}

	method moverHabilidad() {
		if (habilidad != #{}) {
			self.elementoQueEstaDentroDeHabilidad().position(direccionMovimiento.siguiente(position, velocidad, true))
		}
	}
	
	method elementoQueEstaDentroDeHabilidad(){
		return self.habilidad().asList().first()
	}

	method mover(direccion) {
		const positionSiguiente = direccion.siguiente(position, velocidad, cambioDireccion)
		self.validarPosition(positionSiguiente)
		position = positionSiguiente
		direccionMovimiento = direccion
		self.moverHabilidad()
	}

	method puertaMismaPosition() {
		const objetosMismaPosicion = self.position().allElements()
		objetosMismaPosicion.remove(self)
		if (not objetosMismaPosicion.any({ objeto => objeto.esPuerta()})) {
			self.error("No hay puerta para entrar")
		}
		musica.cancion("puerta.mp3", false,100)
		return objetosMismaPosicion.find({ objeto => objeto.esPuerta() })
	}

	method salirPuerta() {
		direccionMovimiento = frente
		self.moverHabilidad()
	}

	method entrarPuerta() {
		const puerta = self.puertaMismaPosition()
		puerta.trasladar(self)
		self.salirPuerta()
	}

	method agarrar(_habilidad) {
		habilidad = _habilidad
		self.moverHabilidad()
	}

	method limpiarHabilidad() {
		game.removeVisual(self.elementoQueEstaDentroDeHabilidad())
		habilidad.clear()
	}

	method accionarHabilidad() {
		if (habilidad == null) {
			self.error('No hay habilitad para usar')
		}
		self.elementoQueEstaDentroDeHabilidad().actuar(self)
		self.limpiarHabilidad()
		musica.cancion("sonidoHabilidad.mp3",false,100)
	}

}

object mario inherits Personaje(imagePersonaje = "mario_", direccionMovimiento = derecha, oponente = luigi, habilidad = #{cambiadorDeTeclas}) {

	override method plataformaInicial() = self.nivelPlataformaInicial().first()

}

object luigi inherits Personaje(imagePersonaje = "luigi_", direccionMovimiento = izquierda, oponente = mario, habilidad = #{aumentarVelocidad}) {

	override method plataformaInicial() = self.nivelPlataformaInicial().last()

}

