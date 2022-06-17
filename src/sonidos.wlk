import wollok.game.*

object sonido {
	
	method iniciar(_sonido, loop, tiempo) {
		const sonido = game.sound(_sonido)
		sonido.volume(0.5)
		sonido.shouldLoop(loop)
		game.schedule(tiempo, { sonido.play()})
	}

}

