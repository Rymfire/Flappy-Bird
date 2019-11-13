# Flappy-Bird
[Flappy Bird](https://en.wikipedia.org/wiki/Flappy_Bird) is an arcade mobile video game created by ".GEARS Studios" in 2013. The aim of Flappy Bird is to navigate the bird through green pipes. The player scores one point for each set of pipes successfully passed. Sadly, this game was removed from all plateforms on early 2014.

This is a reproduction of the famous Flappy Bird made using Godot3.

Thanks for [Angega Studios](https://www.youtube.com/channel/UChv-gaPlKNROf6iMDhxIpUA) for the help (guide and ressources) even if the [tutorial](https://www.youtube.com/playlist?list=PLv3l-oZCXaql20IlPe7gfBEzomnPSLekY) is a bit obsolete now.

## Architecture

Le code s'agence autour de la scene [Bird](https://github.com/Rymfire/Flappy-Bird/blob/master/Script/Bird.gd). J'utilise un "finite state machine" pour gerer les differents etats de mon jeu:

![FlappyBird FiniteStateMachine](/Docs/FlappyBird-FiniteStateMachine.png)
> *Made with [Mermaid.JS](https://mermaidjs.github.io/mermaid-live-editor/)*
