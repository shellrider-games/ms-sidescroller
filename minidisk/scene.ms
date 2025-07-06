ensureImport "mapUtil"

Scene = {}
Scene.actors = []
Scene.inputActions = {}

Scene.init = function
    self.inputActions = {}
end function
Scene.requestSceneSwitch = function(sceneName)
    print "requestSceneSwitch not set"
end function

Scene.onLoad = function
    self.actors = []
end function

Scene.onLoadEnd = function
    for actor in self.actors
        actor.onLoad
    end for
end function

Scene.onUnload = function
    self.actors = []
end function

Scene.update = function(deltaTime)
    for actor in self.actors
        actor.update deltaTime
    end for
end function

Scene.executeInputAction = function(actionName)
    if self.inputActions.hasIndex(actionName) then self.inputActions[actionName]
end function