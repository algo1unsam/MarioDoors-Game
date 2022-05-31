import dificultades.*
import direcciones.*
import personajes.*
import tablero.*
import torreDePuertas.*
import validaciones.*
import wollok.game.*

object velocidad {
//-Hacer que vaya mas rapido el personaje (hacer que la posicion cambie de a 3 celda -> cambio de velocidad)
	method actuar(personaje){
		personaje.velocidad(2)
		game.schedule(3000,{personaje.velocidad(1)})		
	}
}

object cambiadorDeTeclas {
	//-Cambio de direccion de las teclas del oponente por x segundos (metodo onTick - implementar con un on/off en la direccion de las teclas)
	method actuar(oponente){
		oponente.cambioDireccion(true)
		game.schedule(3000,{oponente.cambioDireccion(false)})
	}
}

object ayudaDePuerta {
	//-Cambiar color de la puerta que lleva al piso inferior
	method actuar(parametroSinUso){
		//Hacer
	}
}

object freezearAlOponente {
	//-Hacer que el oponente se detenga por x segundos (hacer que la posicion cambie de a 0 celda -> cambio de velocidad) (metodo onTick - implementar con un on/off en la direccion de las teclas)
	method actuar(oponente){
		oponente.velocidad(0)
		game.schedule(3000,{oponente.velocidad(1)})	
	}	
}

