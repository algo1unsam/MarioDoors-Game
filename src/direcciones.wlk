import wollok.game.*
import personajes.*

class Direccion {
	method siguiente(positionActual, velocidad,cambioDireccion) = positionActual
}

object frente inherits Direccion {
	
}

object izquierda inherits Direccion {
	override method siguiente(positionActual, velocidad,cambioDireccion){
		if (! cambioDireccion){
			return positionActual.left(velocidad)
		}
		else{
			return positionActual.right(velocidad)
		}
	} 

}

object derecha inherits Direccion {

	override method siguiente(positionActual, velocidad,cambioDireccion){
		if (! cambioDireccion){
			return positionActual.right(velocidad)
		}
		else{
			return positionActual.left(velocidad)
		}
	} 
}



