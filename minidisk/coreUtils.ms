globals.ensureImport = function(moduleName)
	if globals.hasIndex(moduleName) then return
	globals[moduleName] = "PENDING"
	import moduleName
	globals[moduleName] = locals[moduleName]
end function