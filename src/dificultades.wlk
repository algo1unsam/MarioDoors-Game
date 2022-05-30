import wollok.game.*
import menuInicial.*

class Dificultad {
	
	const imageDificultad
	var property imageSeleccionada = ""
	const property position
	
	method image() = imageDificultad + imageSeleccionada + ".png"

	method cantidadNiveles() = 3
	
	method seleccionar(){
		imageSeleccionada = "_seleccionada"
	}
	
	method deseleccionar(){
		imageSeleccionada = ""
	}

}

object dificultadUno inherits Dificultad(imageDificultad="dificultad_uno", position=pressEnter.position().down(3)){

}

object dificultadDos inherits Dificultad(imageDificultad="dificultad_dos", position=dificultadUno.position().down(2)){

	override method cantidadNiveles() = 4

}
