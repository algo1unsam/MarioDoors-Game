import wollok.game.*

class Personaje{
	const property image
	var property position = game.at(0,0)
	
	method moverArriba(){
		position = self.position().up(1)
	}
	
	method moverAbajo(){
		position = self.position().down(1)
	}
	
	method moverIzquierda(){
		position = self.position().left(1)
	}
	
	method moverDerecha(){
		position = self.position().right(1)
	}
}

object mario inherits Personaje(image = "./assets/mario.png", position = game.at(0,0)) {

}

object donkeyKong inherits Personaje(image = "./assets/bb (1).png", position = game.at(9,0)) {

}

