import wollok.game.*
import torreDePuertas.*
import personajes.*
import teclado.*

object tablero {

	method iniciar(){
		game.title("Mario Doors Game")
		game.width(15)
		game.height(12)
		game.boardGround("ImagenPresentacion.jpg") /*Tenemos que utilizar una imagen que ayude
		 cuando setteamos el juego. No se puede reemplazar el fondo de pantalla*/
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
		game.boardGround("buenas2.jpg")
	}

	method agregarTorreDePuertas() {
		torreDePuertas.agregarAlTablero()
	}

	method agregarPersonajes() {
		game.addVisual(mario)
		game.addVisual(luigi)
	}
}

