import wollok.game.*



object musica{
	method cancion(sonido,loop,tiempo){
			const musicaFondo = game.sound(sonido)
			//console.println("iniciar sonido")
			musicaFondo.volume(0.5)
			musicaFondo.shouldLoop(loop)
			game.schedule(tiempo, { musicaFondo.play()} )
			
	}
}
