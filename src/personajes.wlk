import wollok.game.*
import torreDePuertas.*
import direccionesMovimiento.*
import validaciones.*


class Personaje {

	const property image
	var property position = self.positionInicial() //game.at(0, 0)
	var property velocidad = 1

	method positionInicial() = torreDePuertas.nivelesPlataformas().first().plataformas()

	method mover(direccion) {
		const puedoMoverme = self.confirmacionDeMovimiento(direccion)
		if (puedoMoverme == 1) {position = direccion.siguiente(position, velocidad)} else {}
		
	}

	method confirmacionDeMovimiento(direccion){
		const positionSiguiente = direccion.siguiente(position, velocidad)
		return mundo.validacionProximaPosicion(positionSiguiente, self)
		
	}
	
	method entrarPuerta() {
		const objetosMismaPosicion = self.position().allElements()
		if (not objetosMismaPosicion.any({ objeto => objeto.esPuerta()})) {
			self.error("No hay puerta para entrar")
		}
		const puerta = objetosMismaPosicion.find({ objeto => objeto.esPuerta() })
		puerta.trasladar(self)
	}

}


object mario inherits Personaje(image = "jugador1.png") {
	
	override method positionInicial() = super().first().position().up(1)

}

object luigi inherits Personaje(image = "jugador2.png") {
	
	override method positionInicial() = super().last().position().up(1)

}

