import wollok.game.*

object mundo{
	
	method validacionProximaPosicion(proximaPosition, personaje){
		const puedoMovermeEjeX = self.validacionEjeX(proximaPosition, personaje)
		const puedoMovermeEjeY = self.validacionEjeY(proximaPosition, personaje)
		return if (puedoMovermeEjeX == 1 and puedoMovermeEjeY == 1){1}else{0}
		
	}
	
	method validacionEjeX(proximaPosition,personaje){
		return if (! proximaPosition.x().between(0, game.width() - 1)){
			personaje.error("Posicion fuera de ancho")
			//return 0
		}
		else{1}
		
	}
	
	method validacionEjeY(proximaPosition,personaje){
		return if(! proximaPosition.y().between(0, game.height() - 1)) {
			personaje.error("Posicion fuera de alto")
		} else{1}
		
	}
}
