ensureImport "spriteActor"

PlayerCharacter = new spriteActor.SpriteActor

PlayerCharacter.platforms = []
PlayerCharacter.inputVector = 0
PlayerCharacter.speed = 200
PlayerCharacter.jumpStrength = 500
PlayerCharacter.velocity = {"x": 0, "y": 0}
PlayerCharacter.gravity = 800

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

PlayerCharacter.handleMovement = function(deltaTime)
    self.velocity.y = self.velocity.y - self.gravity * deltaTime
    self.velocity.x = self.inputVector * self.speed
    self.position.x = self.position.x + self.velocity.x * deltaTime
    self.position.y = self.position.y + self.velocity.y * deltaTime
end function

PlayerCharacter.handleGroundCollision = function
    if self.position.y <  self.sprite.worldBounds.height * 0.5 then
        self.position.y = self.sprite.worldBounds.height * 0.5
        self.velocity.y = 0
    end if
end function

PlayerCharacter.handlePlatformCollisions = function
    for platform in self.platforms
        if self.sprite.worldBounds.overlaps(platform.sprite.worldBounds) and self.isGroundedOn(platform) and self.velocity.y < 0 then
            self.position.y = platform.sprite.worldBounds.y + platform.sprite.worldBounds.height * 0.5 + self.sprite.worldBounds.height * 0.5
            self.velocity.y = 0
        end if
    end for
end function

PlayerCharacter.isGroundedOn = function(platform) 
    botBounds = new Bounds
    botBounds.x = self.sprite.worldBounds.x
    botBounds.y = self.sprite.worldBounds.y - self.sprite.worldBounds.height * 0.5 - 1
    botBounds.width = self.sprite.worldBounds.width
    botBounds.height = 2
    return botBounds.overlaps(platform.sprite.worldBounds)
end function

PlayerCharacter.isGrounded = function
    for platform in self.platforms
        if self.isGroundedOn(platform) then return true
    end for
    return self.position.y <= self.sprite.worldBounds.height * 0.5
end function

PlayerCharacter.update = function(deltaTime)
    self.handlePlatformCollisions
    self.handleMovement deltaTime
    self.handleGroundCollision
    super.update delta
end function

PlayerCharacter.jump = function
    if self.isGrounded then
        self.velocity.y = self.jumpStrength
    end if
end function