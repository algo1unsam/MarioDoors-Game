import configuracionesDificultad.*
import direccionesMovimiento.*
import escenarios.*
import objects.*
import personajes.*
import tablero.*
import torreDePuertas.*
import validaciones.*
import wollok.game.*


class Relentizador{
	//-Hacer que vaya mas lento el oponente (hacer que la posicion cambie de a 1 celda -> cambio de velocidad)
	
	method actuar(oponente){
		oponente.velocidad(1)
		game.schedule(3000,{oponente.velocidad(2)})	
	}
}

class Velocidad {
//-Hacer que vaya mas rapido el personaje (hacer que la posicion cambie de a 3 celda -> cambio de velocidad)
	method actuar(personaje){
		personaje.velocidad(3)
		game.schedule(3000,{personaje.velocidad(2)})		
	}
}

class CambiadorDeTeclas {
	//-Cambio de direccion de las teclas del oponente por x segundos (metodo onTick - implementar con un on/off en la direccion de las teclas)
	method actuar(){
		
	}
}

class AyudaDePuerta {
	//-Cambiar color de la puerta que lleva al piso inferior
	method actuar(){
		
	}
}

class FreezearAlOponente {
	//-Hacer que el oponente se detenga por x segundos (hacer que la posicion cambie de a 0 celda -> cambio de velocidad) (metodo onTick - implementar con un on/off en la direccion de las teclas)
	method actuar(oponente){
		oponente.velocidad(0)
		game.schedule(3000,{oponente.velocidad(2)})	
	}	
}

