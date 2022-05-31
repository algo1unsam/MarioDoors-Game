import wollok.game.*
import torreDePuertas.*
import direcciones.*
import validaciones.*
import habilidades.*

class Personaje {

	const imagePersonaje
	var property position = self.positionInicial()
	var property direccionMovimiento
	var property velocidad = 1
	var property cambioDireccion = false
	const property habilidades = #{}
	const property habilidadesQueAfectanAlRival = #{cambiadorDeTeclas,freezearAlOponente}
	
	method image() = imagePersonaje + self.imageDireccion() + ".png"

	method imageDireccion() = direccionMovimiento.toString()

	method positionInicial() = self.plataformaInicial().position().up(1)

	method nivelPlataformaInicial() = torreDePuertas.nivelesPlataformas().first().plataformas()

	method plataformaInicial() = self.nivelPlataformaInicial().anyOne()

	method validarPosition(positionSiguiente) {
		mundo.validarPosition(positionSiguiente, self)
	}

	method mover(direccion) {
		const positionSiguiente = direccion.siguiente(position, velocidad,cambioDireccion)
		self.validarPosition(positionSiguiente)
		position = positionSiguiente
		direccionMovimiento = direccion
	}

	method salirPuerta() {
		direccionMovimiento = frente
	}

	method entrarPuerta() {
		const objetosMismaPosicion = self.position().allElements()
		objetosMismaPosicion.remove(self)
		if (not objetosMismaPosicion.any({ objeto => objeto.esPuerta()})) {
			self.error("No hay puerta para entrar")
		}
		const puerta = objetosMismaPosicion.find({ objeto => objeto.esPuerta() })
		puerta.trasladar(self)
		self.salirPuerta()
	}
	
	method agarrar(habilidad){
		if (habilidades.isEmpty()){
			self.restartHabilidades()
			habilidades.add(habilidad)
		}
	}
	
	method restartHabilidades() {
		habilidades.clear() 
	}
	
	method accionarHabilidad(){
		if (not habilidades.isEmpty()){
			habilidades.forEach({habilidad => habilidad.actuar(self)})
			self.restartHabilidades()
		}
	}
	
	method verificarSiLaHabilidadAfectaAlRival(){
		return self.estaFreezearAlOponenteOCambiadorDeTeclasEnHabilidades()
	}
	
	method estaFreezearAlOponenteOCambiadorDeTeclasEnHabilidades(){
		return habilidades.intersection(habilidadesQueAfectanAlRival) != #{}
	}
	
}

object mario inherits Personaje(imagePersonaje = "mario_", direccionMovimiento = derecha) {

	override method plataformaInicial() = self.nivelPlataformaInicial().first()
	
	override method accionarHabilidad(){
		if (self.verificarSiLaHabilidadAfectaAlRival() and not habilidades.isEmpty()){
			habilidades.forEach({habilidad => habilidad.actuar(luigi)})
			self.restartHabilidades()
		}
		else{
			super()
		}
	}
}

object luigi inherits Personaje(imagePersonaje = "luigi_", direccionMovimiento = izquierda) {

	override method plataformaInicial() = self.nivelPlataformaInicial().last()
	
	override method accionarHabilidad(){
		if (self.verificarSiLaHabilidadAfectaAlRival()){
			habilidades.forEach({habilidad => habilidad.actuar(mario)})
			self.restartHabilidades()
		}
		else{
			super()
		}
		
	}
}

