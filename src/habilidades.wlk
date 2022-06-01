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
		game.schedule(3000, { personaje.velocidad(1)})
	}

}

object cambiadorDeTeclas inherits Habilidad(image = 'item_azul.png') {

	// -Cambio de direccion de las teclas del oponente por x segundos (metodo onTick - implementar con un on/off en la direccion de las teclas)
	override method actuar(personaje) {
		game.schedule(1000, { personaje.oponente().cambioDireccion(true)})
	}

}

object ayudaDePuerta inherits Habilidad(image = 'item_verde.png') {

	// -Cambiar color de la puerta que lleva al piso inferior
	override method actuar(parametroSinUso) {
	// Hacer
	}

}

object freezearAlOponente inherits Habilidad(image = 'item_violeta.png') {

	// -Hacer que el oponente se detenga por x segundos (hacer que la posicion cambie de a 0 celda -> cambio de velocidad) (metodo onTick - implementar con un on/off en la direccion de las teclas)
	override method actuar(personaje) {
		game.schedule(1000, { personaje.oponente().velocidad(0)})
	}

}

