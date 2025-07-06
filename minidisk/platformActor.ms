ensureImport "spriteActor"

Platform = new spriteActor.SpriteActor

create = function(x = 0, y = 0)
    noob = new Platform
    noob.sprite = new Sprite
    noob.position = {"x":x, "y": y}
    return noob
end function

Platform.onLoad = function
    self.sprite.image = file.loadImage("sprites/platformPlaceholder.jpg")
    self.sprite.localBounds = new Bounds
    self.sprite.localBounds.width = self.sprite.image.width
    self.sprite.localBounds.height = self.sprite.image.height
    super.onLoad
end function

Platform.update = function(deltaTime)
    super.update deltaTime
end function