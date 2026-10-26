# hangman

## Overview

This is a basic hangman game made for The Odin Project.
The purpose of this project is to learn serialization and I/O in Ruby. 
You can save a game and come back to it later. The program serializes the game at its current state and then outputs that to a file in the saves/ directory when you save and quit. When you start a game from a save file it will deserialize it and then instantiate a Game from the deserialized file.