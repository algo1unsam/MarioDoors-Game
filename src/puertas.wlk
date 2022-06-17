import wollok.game.*
import sonidos.*

class Puerta {

	const imagenPuerta = 'puerta'
	var property position
	const property esPuerta = true
	const property esPuertaFinal = false
	var property estaAbierta = false
	var property estaIluminada = false
	var property puertaDestino = null
	const sonidoPuerta = "sonidoPuerta.mp3"

	method image() = imagenPuerta + self.imagenAbierta() + self.imagenIluminada() + ".png"

	method imagenAbierta() = if (estaAbierta) "_abierta" else ""

	method imagenIluminada() = if (estaIluminada) "_iluminada" else ""

	method iluminar() {
		game.onTick(500, "iluminarPuerta", { if (estaIluminada) {
				estaIluminada = false
			} else {
				estaIluminada = true
			}
		})
		game.schedule(3500, { game.removeTickEvent("iluminarPuerta")
		; estaIluminada = false
		})
	}

	method accionarSonido() {
		sonido.iniciar(sonidoPuerta, false, 100)
	}

	method abrir() {
		self.accionarSonido()
		estaAbierta = true
		game.schedule(1000, { estaAbierta = false})
	}

	method trasladar(personaje) {
		self.abrir()
		personaje.position(puertaDestino.position())
		puertaDestino.entrar(personaje)
	}

	method entrar(personaje) {
		self.abrir()
	}

}

class PuertaFinal inherits Puerta(esPuertaFinal = true) {

	var property puertaOrigen = null

	override method entrar(personaje) {
		super(personaje)
		game.say(personaje, "¡GANÉ!")
	}

}

