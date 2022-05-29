import wollok.game.*
import torreDePuertas.*
import personajes.*
import teclado.*


object pressEnter{
	const property position = game.at(2, game.height()/2)
	const property image = 'PressEnter-White-Resized.png'
}

object tablero {

	method iniciar(){
		game.title("Mario Doors Game")
		game.width(15)
		game.height(18)
		game.ground("groundBlack.png")
		//game.boardGround("ImagenPresentacion.jpg") 
		/*Tenemos que utilizar una imagen que ayude
		 cuando setteamos el juego. No se puede reemplazar el fondo de pantalla*/
		game.addVisual(pressEnter)
		keyboard.space().onPressDo({self.setearEntorno()})
	}
	
	method setearEntorno(){
		game.clear()
		self.crearDimensiones()
		self.agregarTorreDePuertas()
		self.agregarPersonajes()
		teclado.configurarTeclas()
	}
	
	method crearDimensiones(){
		//game.width(15)
		//game.height(12)
		//game.cellSize(50)
		//game.boardGround("buenas2.jpg")
		game.ground("groundWhite.png")
	}

	method agregarTorreDePuertas() {
		torreDePuertas.agregarAlTablero()
	}

	method agregarPersonajes() {
		game.addVisual(mario)
		game.addVisual(luigi)
	}
}
