import wollok.game.*


object mario {
	var property position = game.center()
	const property image = "jugador1.png"
	
	method moverIzq(){
		const proximaPosition = position.left(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoIzq.verificacion(self).isEmpty()){
			position = position.left(1)
		}
	}
	method moverDer(){
		const proximaPosition = position.right(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoDer.verificacion(self).isEmpty()){
			position = position.right(1)
		}
	}
	method moverArriba(){
		const proximaPosition = position.up(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoArriba.verificacion(self).isEmpty()){
			position = position.up(1)
		}
	}
	method moverAbajo(){
		const proximaPosition = position.down(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoAbajo.verificacion(self).isEmpty()){
			position = position.down(1)
		}
	}
	
	

}

object mundo {
	method validarPosition(_position,personaje){
		if (! _position.x().between(0, game.width() -1)){
			personaje.error("Posicion fuera de ancho")
		}	
		
		if(! _position.y().between(0, game.height() - 1)) {
			personaje.error("Posicion fuera de alto")
		}
	}
}

object luigi {
	var property position = game.center()
	const property image = "jugador2.png"

	method moverIzq(){
		const proximaPosition = position.left(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoIzq.verificacion(self).isEmpty()){
			position = position.left(1)
		}
	}
	method moverDer(){
		const proximaPosition = position.right(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoDer.verificacion(self).isEmpty()){
			position = position.right(1)
		}
	}
	method moverArriba(){
		const proximaPosition = position.up(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoArriba.verificacion(self).isEmpty()){
			position = position.up(1)
		}
	}
	method moverAbajo(){
		const proximaPosition = position.down(1)
		mundo.validarPosition(proximaPosition,self)
		if (hayAlgoAbajo.verificacion(self).isEmpty()){
			position = position.down(1)
		}
	}
}

object hayAlgoArriba{
	method verificacion(personaje){
		const elementos = personaje.position().up(1).allElements()
		elementos.remove(self)
		return elementos
	 }
}
object hayAlgoIzq{
	method verificacion(personaje){
		const elementos = personaje.position().left(1).allElements()
		elementos.remove(self)
		return elementos
	 }
}
object hayAlgoAbajo{
	method verificacion(personaje){
		const elementos = personaje.position().down(1).allElements()
		elementos.remove(self)
		return elementos
	 }
}
object hayAlgoDer{
	method verificacion(personaje){
		const elementos = personaje.position().right(1).allElements()
		elementos.remove(self)
		return elementos
	 }
}