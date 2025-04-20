import "coreUtils"

ensureImport "listUtil"
ensureImport "mapUtil"
ensureImport "scene"
ensureImport "actor"
ensureImport "spriteActor"

sceneManager = {}
sceneManager.scenes = {}

sceneManager.currentScene = null
sceneManager.switchScene = function(sceneName)
    if not sceneManager.scenes.get(sceneName) then
        "Print could not find scene with name: " + sceneName
        return
    end if
    scene = sceneManager.scenes.get(sceneName)
    if sceneManager.currentScene != null then sceneManager.currentScene.onUnload
    sceneManager.currentScene = scene
    sceneManager.currentScene.requestSceneSwitch = @sceneManager.switchScene
    sceneManager.currentScene.onLoad
end function

sceneManager.alreadyPressedKeys = []

sceneManager.inputMap = {}
sceneManager.inputMap["left"] = "prevScene"
sceneManager.inputMap["right"] = "nextScene"
sceneManager.handleInputActions = function
    for inputKey in self.inputMap.indexes
        if not self.alreadyPressedKeys.contains(inputKey) and key.pressed(inputKey) then 
            self.currentScene.executeInputAction self.inputMap[inputKey]
            self.alreadyPressedKeys.push inputKey
        end if
    end for
end function

sceneManager.cleanPressedKeys = function
    toRemove = []
    for pressedKey in self.alreadyPressedKeys
        if not key.pressed(pressedKey) then toRemove.push pressedKey
    end for
    for pressedKey in toRemove
        self.alreadyPressedKeys.removeVal pressedKey
    end for
end function

scene1 = new scene.Scene
scene1.init
scene1.onLoad = function
    super.onLoad
    print "Loaded Scene1"
end function
scene1.inputActions["nextScene"] = function
    print "Request loading Scene2"
    scene1.requestSceneSwitch "Scene2"
end function

sceneManager.scenes["Scene1"] = scene1

scene2 = new scene.Scene
scene2.init
scene2.onLoad = function
    super.onLoad
    myWumpus = new spriteActor.SpriteActor
    myWumpus.elapsed = 0
    myWumpus.onLoad = function
        myWumpus.sprite.image = file.loadImage("/sys/pics/Wumpus.png")
        myWumpus.position.x = 480
        myWumpus.position.y = 320
        super.onLoad
    end function
    myWumpus.update = function(deltaTime)
        myWumpus.elapsed += deltaTime
        myWumpus.position.x = 480 + 200 * sin(2*myWumpus.elapsed)
        myWumpus.position.y = 320 + 100 * cos(2*myWumpus.elapsed)
        myWumpus.rotation = (myWumpus.rotation + 50 * deltaTime) % 360
        super.update deltaTime
    end function

    scene2.actors.push myWumpus
    for actor in scene2.actors
        actor.onLoad
    end for
end function
scene2.inputActions["prevScene"] = function
    print "Request loading Scene1"
    scene2.requestSceneSwitch "Scene1"
end function
scene2.onUnload = function
    for actor in scene2.actors
        actor.onUnload
    end for
    super.onUnload
end function

sceneManager.scenes["Scene2"] = scene2

sceneManager.switchScene "Scene1"

lastTimestamp = time
while true
    currentTimestamp = time
    delta = currentTimestamp - lastTimestamp
    lastTimestamp = currentTimestamp
    sceneManager.cleanPressedKeys
    sceneManager.handleInputActions
    sceneManager.currentScene.update delta
    yield
end while