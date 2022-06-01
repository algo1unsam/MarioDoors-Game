import wollok.game.*

class Habilidad {

	const property image
	var property position = game.at(0, 0)

	method actuar(personaje)

}

object aumentarVelocidad inherits Habilidad(image = 'item_rojo.png') {

//-Hacer que vaya mas rapido el personaje (hacer que la posicion cambie de a 3 celda -> cambio de velocidad)
	override method actuar(personaje) {
		personaje.velocidad(2)
		game.say(personaje, 'Mas velocidad')
		game.schedule(3000, { personaje.velocidad(1)})
	}

}

object cambiadorDeTeclas inherits Habilidad(image = 'item_azul.png') {

	// -Cambio de direccion de las teclas del oponente por x segundos (metodo onTick - implementar con un on/off en la direccion de las teclas)
	override method actuar(personaje) {
		const oponente = personaje.oponente()
		oponente.cambioDireccion(true)
		game.say(oponente, 'Me muevo al revés')
		game.schedule(10000, { personaje.oponente().cambioDireccion(false)})
	}

}

object ayudaDePuerta inherits Habilidad(image = 'item_verde.png') {

	// -Cambiar color de la puerta que lleva al piso inferior
	override method actuar(personaje) {
	// TODO
	}

}

object freezearAlOponente inherits Habilidad(image = 'item_violeta.png') {

	// -Hacer que el oponente se detenga por x segundos (hacer que la posicion cambie de a 0 celda -> cambio de velocidad) (metodo onTick - implementar con un on/off en la direccion de las teclas)
	override method actuar(personaje) {
		const oponente = personaje.oponente()
		oponente.velocidad(0)
		game.say(oponente, 'Congelado')
		game.schedule(10000, { personaje.oponente().velocidad(1)})
	}

}

