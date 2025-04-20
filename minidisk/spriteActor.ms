ensureImport "actor"
ensureImport "listUtil"

SpriteActor = new actor.Actor
SpriteActor.sprite = new Sprite
SpriteActor.position = {"x":0, "y":0}
SpriteActor.rotation = 0

SpriteActor.onLoad = function
    super.onLoad
    display(4).sprites.push self.sprite
end function

SpriteActor.update = function(deltaTime)
    super.update deltaTime
    self.sprite.x = self.position.x
    self.sprite.y = self.position.y
    self.sprite.rotation = self.rotation
end function

SpriteActor.onUnload = function
    super.onUnload
    display(4).sprites.removeVal self.sprite
end function