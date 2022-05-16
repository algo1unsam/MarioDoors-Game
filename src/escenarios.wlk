import wollok.game.*
import objects.*
import personajes.*

object escenario {
	
	method primero(){
		const primeraFila = [1,2,3,4,5,6,7,8]
		const altura = 7
		
		game.addVisual(new Plataforma(position = game.at(primeraFila.first(),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.get(1),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.get(2),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.get(3),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.get(4),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.get(5),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.get(6),altura)))
		game.addVisual(new Plataforma(position = game.at(primeraFila.last(),altura)))
	}
	
	
}
