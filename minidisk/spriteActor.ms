ensureImport "actor"
ensureImport "listUtil"

SpriteActor = new actor.Actor
SpriteActor.sprite = null
SpriteActor.position = null
SpriteActor.rotation = 0

create = function(sprite, position, rotation = 0)
    noob = new SpriteActor
    noob.sprite = sprite
    noob.position = position
    noob.rotation = rotation
    return noob
end function

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