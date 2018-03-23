local CraftingJob = require 'stonehearth.jobs.crafting_job'

local FireStarterClass = class()
radiant.mixin(FireStarterClass, CraftingJob)

return FireStarterClass
