Fiber = Npm.require('fibers');

@Session = 
	
	get: (key)->
		slot = DDP._CurrentInvocation?.slot
		if slot
			if Fiber.current._meteor_dynamics?[slot]?.connection
				return Fiber.current._meteor_dynamics[slot].connection[key]
		return null

	set: (key, value)->
		slot = DDP._CurrentInvocation?.slot
		if slot
			if Fiber.current._meteor_dynamics?[slot]?.connection
				Fiber.current._meteor_dynamics[slot].connection[key] = value