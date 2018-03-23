local CraftingJob = require 'stonehearth.jobs.crafting_job'

local ThatcherClass = class()
radiant.mixin(ThatcherClass, CraftingJob)

return ThatcherClass
