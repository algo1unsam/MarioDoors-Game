import wollok.game.*
import direcciones.*
import sonidos.*
import torreDePuertas.*

class Habilidad {

	const imageHabilidad
	var property position = game.at(0, 0)
	const velocidad = 1
	const cambioDireccion = true
	var direccionMovimiento = frente
	const sonidoHabilidad = "sonidoHabilidad.mp3"

	method image() = imageHabilidad + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method posicionSiguiente(direccion, posicionPersonaje) = direccion.siguiente(posicionPersonaje, velocidad, cambioDireccion)

	method mover(direccion, posicionPersonaje) {
		const posicionSiguiente = self.posicionSiguiente(direccion, posicionPersonaje)
		position = posicionSiguiente
		direccionMovimiento = direccion
	}

	method accionarSonido() {
		sonido.iniciar(sonidoHabilidad, false, 100)
	}

	method actuar(personaje) {
		self.accionarSonido()
	}

}

object aumentarVelocidad inherits Habilidad(imageHabilidad = 'item_rojo_') {

	// Hace que vaya mas rapido el personaje
	override method actuar(personaje) {
		super(personaje)
		personaje.velocidad(2)
		game.say(personaje, 'Mas velocidad')
		game.schedule(10000, { personaje.velocidad(1)})
	}

}

object cambiadorDeTeclas inherits Habilidad(imageHabilidad = 'item_azul_') {

	// Cambia de direccion de las teclas del oponente por x segundos
	override method actuar(personaje) {
		super(personaje)
		const oponente = personaje.oponente()
		oponente.cambioDireccion(true)
		game.say(oponente, 'Me muevo al revés')
		game.schedule(10000, { personaje.oponente().cambioDireccion(false)})
	}

}

object freezearAlOponente inherits Habilidad(imageHabilidad = 'item_violeta_') {

	// Hace que el oponente se detenga por x segundos
	override method actuar(personaje) {
		super(personaje)
		const oponente = personaje.oponente()
		oponente.velocidad(0)
		game.say(oponente, 'Congelado')
		game.schedule(5000, { personaje.oponente().velocidad(1)})
	}

}

object ayudaPuertaFinal inherits Habilidad(imageHabilidad = 'item_verde_') {

	// Cambia color de la puerta que lleva a la puerta final
	override method actuar(personaje) {
		torreDePuertas.puertaQueLlevaPuertaFinal().iluminar()
	}

}

object llavePuertaFinal inherits Habilidad(imageHabilidad = 'llave_', cambioDireccion = false) {

	// Hace la siguiente puerta que entre el personaje lo lleve a la puerta final
	override method actuar(personaje) {
		const puertaMismaPosicion = personaje.puertaMismaPosicion()
		const puertaFinal = torreDePuertas.puertaFinal()
		puertaMismaPosicion.puertaDestino(puertaFinal)
		puertaMismaPosicion.trasladar(personaje)
	}

}

object habilidadesFactory {

//	const habilidades = [ freezearAlOponente ]
}

