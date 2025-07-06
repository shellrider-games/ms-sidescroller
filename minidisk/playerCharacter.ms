ensureImport "spriteActor"

PlayerCharacter = new spriteActor.SpriteActor

create = function(x = 0, y = 0)
    noob = new PlayerCharacter
    noob.sprite = new Sprite
    noob.position = {"x": x, "y": y}
    return noob
end function

PlayerCharacter.onLoad = function
    self.sprite.image = file.loadImage("sprites/playerCharacter.png")
    self.sprite.localBounds = new Bounds
    self.sprite.localBounds.width = self.sprite.image.width
    self.sprite.localBounds.height = self.sprite.image.height
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

    if self.position.y <  self.sprite.worldBounds.height * 0.5 then
        self.position.y = self.sprite.worldBounds.height * 0.5
        self.velocity.y = 0
    end if
    super.update delta
end function

PlayerCharacter.jump = function
    if self.position.y <= self.sprite.worldBounds.height * 0.5 then
        self.velocity.y = self.jumpStrength
    end if
end function