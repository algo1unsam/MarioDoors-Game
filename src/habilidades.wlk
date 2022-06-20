import wollok.game.*
import elementosVisibles.*
import direcciones.*
import sonidos.*
import torreDePuertas.*

class Habilidad inherits ElementoMovible(esHabilidad = true, cambioDireccion = true) {

	const sonidoHabilidad = "sonidoHabilidad.mp3"
	const direccionMovimientoInicial = frente

	override method seteoInicial() {
		direccionMovimiento = direccionMovimientoInicial
	}

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

object aumentarVelocidad inherits Habilidad(image = 'item_rojo_') {

	// Hace que vaya mas rapido el personaje
	override method actuar(personaje) {
		super(personaje)
		personaje.velocidad(2)
		game.say(personaje, 'Mas velocidad')
		game.schedule(10000, { personaje.velocidad(1)})
	}

}

object cambiadorDeTeclas inherits Habilidad(image = 'item_azul_') {

	// Cambia de direccion de las teclas del oponente por x segundos
	override method actuar(personaje) {
		super(personaje)
		const oponente = personaje.oponente()
		oponente.cambioDireccion(true)
		game.say(oponente, 'Me muevo al revés')
		game.schedule(10000, { personaje.oponente().cambioDireccion(false)})
	}

}

object freezearAlOponente inherits Habilidad(image = 'item_violeta_') {

	// Hace que el oponente se detenga por x segundos
	override method actuar(personaje) {
		super(personaje)
		const oponente = personaje.oponente()
		oponente.velocidad(0)
		game.say(oponente, 'Congelado')
		game.schedule(5000, { personaje.oponente().velocidad(1)})
	}

}

object ayudaPuertaFinal inherits Habilidad(image = 'item_verde_') {

	// Cambia color de la puerta que lleva a la puerta final
	override method actuar(personaje) {
		torreDePuertas.puertaQueLlevaPuertaFinal().iluminar()
	}

}

object llavePuertaFinal inherits Habilidad(image = 'llave_', cambioDireccion = false) {

	// Hace la siguiente puerta que entre el personaje lo lleve a la puerta final
	override method actuar(personaje) {
		const puertaMismaPosicion = personaje.puertaMismaPosicion()
		const puertaFinal = torreDePuertas.puertaFinal()
		puertaMismaPosicion.puertaDestino(puertaFinal)
		puertaMismaPosicion.trasladar(personaje)
	}

}

object generadorHabilidades {

	const habilidades = #{ aumentarVelocidad, cambiadorDeTeclas, freezearAlOponente, ayudaPuertaFinal, llavePuertaFinal }
	const habilidadesEnElTablero = #{}

	method habilidadesNoEnElTablero() = habilidades.difference(habilidadesEnElTablero)

	method hayHabilidadesDisponibles() = self.habilidadesNoEnElTablero().isEmpty()

	method agregarAlTablero(position) {
		if (not self.hayHabilidadesDisponibles()) {
			const cualquierHabilidad = self.habilidadesNoEnElTablero().anyOne()
			cualquierHabilidad.position(position)
			cualquierHabilidad.mostrar()
			habilidadesEnElTablero.add(cualquierHabilidad)
		}
	}

	method limpiarHabilidadesEnElTablero() {
		habilidadesEnElTablero.clear()
	}

	method seteoInicial() {
		self.limpiarHabilidadesEnElTablero()
		habilidades.forEach({ habilidad => habilidad.seteoInicial()})
	}

}

