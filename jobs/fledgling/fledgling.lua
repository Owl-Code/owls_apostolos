local Point3 = _radiant.csg.Point3

local FledglingClass = class()
local BaseJob = require 'stonehearth.jobs.base_job'
radiant.mixin(FledglingClass, BaseJob)


function FledglingClass:initialize()
   BaseJob.initialize(self)
end
--[[
   A controller that manages all the relevant data about the worker class
   Fledglings.
]]
function FledglingClass:_create_listeners()
   self._mine_listener = radiant.events.listen(self._sv._entity, 'stonehearth:mine', self, self._on_mine)
   self._fabricate_structure_listener = radiant.events.listen(self._sv._entity, 'stonehearth:fabricate_structure', self, self._on_fabricate_structure)
end

function FledglingClass:_remove_listeners()
   if self._mine_listener_listener then
      self._mine_listener_listener:destroy()
      self._mine_listener_listener = nil
   end

   if self._fabricate_structure_listener then
      self._fabricate_structure_listener:destroy()
      self._fabricate_structure_listener = nil
   end
end

function FledglingClass:_on_mine(args)
      self._job_component:add_exp(self._xp_rewards['mine'])
end
function FledglingClass:_on_fabricate_structure(args)
      self._job_component:add_exp(self._xp_rewards['fabricate_structure'])
end

return FledglingClass
