ensureImport "spriteActor"

PlayerCharacter = new spriteActor.SpriteActor
PlayerCharacter.onLoad = function
    self.sprite.image = file.loadImage("sprites/playerCharacter.png")
    super.onLoad
end function
PlayerCharacter.inputVector = 0
PlayerCharacter.speed = 200
PlayerCharacter.jumpStrength = 500
PlayerCharacter.velocity = {"x": 0, "y": 0}
PlayerCharacter.gravity = 800

PlayerCharacter.update = function(deltaTime)
    self.velocity.y = self.velocity.y - self.gravity * deltaTime
    self.velocity.x = self.inputVector * self.speed
    self.position.x = self.position.x + self.velocity.x * deltaTime
    self.position.y = self.position.y + self.velocity.y * deltaTime

    if self.position.y < 32 then
        self.position.y = 32
        self.velocity.y = 0
    end if

    super.update
end function

PlayerCharacter.jump = function
    if self.position.y == 32 then self.velocity.y = self.jumpStrength
end function