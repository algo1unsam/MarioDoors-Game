import wollok.game.*



object musica{
	
	const musicaFondo = game.sound("TemaPrincipal.mp3")
	method fondo(){
			console.println("iniciar sonido")
			//"TemaPrincipal.mp3".volume(0.5)
			//const musicaFondo = game.sound("TemaPrincipal.mp3")
			musicaFondo.volume(1)
			musicaFondo.shouldLoop(true)
			//musicaFondo.play()
			game.schedule(500, { musicaFondo.play()} )
			
	}
}
