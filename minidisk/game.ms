import "coreUtils"

ensureImport "listUtil"
ensureImport "mapUtil"
ensureImport "scene"
ensureImport "actor"
ensureImport "spriteActor"
ensureImport "playerCharacter"
ensureImport "platformActor"

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
    sceneManager.currentScene.onLoadEnd
end function

sceneManager.alreadyPressedKeys = []

sceneManager.inputMap = {}
sceneManager.inputMap["left"] = "leftDown"
sceneManager.inputMap["right"] = "rightDown"
sceneManager.inputMap["up"] = "upDown"

sceneManager.inputReleaseMap = {}
sceneManager.inputReleaseMap["left"] = "leftUp"
sceneManager.inputReleaseMap["right"] = "rightUp"

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
        inputAction = self.inputReleaseMap.get(pressedKey)
        if inputAction then
            self.currentScene.executeInputAction self.inputReleaseMap[pressedKey]
        end if
        self.alreadyPressedKeys.removeVal pressedKey
    end for
end function

scene1 = new scene.Scene
scene1.init
scene1.horizontalInput = 0
scene1.onLoad = function
    super.onLoad
    pf = platformActor.create(660, 100)
    scene1.actors.push pf

    pf2 = platformActor.create(220, 100)
    scene1.actors.push pf2

    pf3 = platformActor.create(280, 250)
    scene1.actors.push pf3

    scene1.player = playerCharacter.create(560, 320)
    scene1.player.platforms = [pf, pf2 ,pf3]
    scene1.actors.push scene1.player
end function

scene1.inputActions["leftDown"] = function
    scene1.horizontalInput -= 1
end function

scene1.inputActions["leftUp"] = function
    scene1.horizontalInput += 1
end function

scene1.inputActions["rightDown"] = function
    scene1.horizontalInput += 1
end function

scene1.inputActions["rightUp"] = function
    scene1.horizontalInput -= 1
end function

scene1.inputActions["upDown"] = function
    scene1.player.jump
end function


scene1.update = function(deltaTime)
    scene1.player.inputVector = scene1.horizontalInput
    super.update deltaTime
end function

sceneManager.scenes["Scene1"] = scene1

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