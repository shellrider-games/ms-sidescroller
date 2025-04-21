ensureImport "spriteActor"

PlayerCharacter = new spriteActor.SpriteActor
PlayerCharacter.onLoad = function
    self.sprite.image = file.loadImage("sprites/playerCharacter.png")
    super.onLoad
end function
PlayerCharacter.inputVector = 0
PlayerCharacter.speed = 50

PlayerCharacter.update = function(deltaTime)
    self.position.x += self.inputVector * self.speed * deltaTime
    super.update
end function