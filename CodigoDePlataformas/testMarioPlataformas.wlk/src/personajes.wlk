import wollok.game.*

object mario {
	var property position = game.center()
	const property image = "player.png"
	
	method moverIzq(){
		if (hayAlgoIzq.verificacion(self).isEmpty()){
			position = position.left(1)
		}
	}
	method moverDer(){
		if (hayAlgoDer.verificacion(self).isEmpty()){
			position = position.right(1)
		}
	}
	method moverArriba(){
		if (hayAlgoArriba.verificacion(self).isEmpty()){
			position = position.up(1)
		}
	}
	method moverAbajo(){
		if (hayAlgoAbajo.verificacion(self).isEmpty()){
			position = position.down(1)
		}
	}
}

object luigi {
	var property position = game.center()
	const property image = "player.png"

	method moverIzq(){
		if (hayAlgoIzq.verificacion(self).isEmpty()){
			position = position.left(1)
		}
	}
	method moverDer(){
		if (hayAlgoDer.verificacion(self).isEmpty()){
			position = position.right(1)
		}
	}
	method moverArriba(){
		if (hayAlgoArriba.verificacion(self).isEmpty()){
			position = position.up(1)
		}
	}
	method moverAbajo(){
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
