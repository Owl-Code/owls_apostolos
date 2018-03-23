local Point3 = _radiant.csg.Point3

local FledglingClass = class()
local BaseJob = require 'stonehearth.jobs.base_job'
radiant.mixin(FledglingClass, BaseJob)


function FledglingClass:initialize()
   BaseJob.initialize(self)
end
--[[
   A controller that manages all the relevant data about the worker class
]]-- 


function FledglingClass:_create_listeners()
    
   self._mine_listener = radiant.events.listen(self._sv._entity,
      'stonehearth:mined_location'
        , self, self._on_mine)
    
       self._gather_listener = radiant.events.listen(self._sv._entity, 'stonehearth:gather_resource'
        , self, self._on_gather)
    
    self._place_listener = radiant.events.listen(self._sv._entity, 'stonehearth:item_placed'
        , self, self._on_place)
    
end

function FledglingClass:_remove_listeners()
   if self._mine_listener then
      self._mine_listener:destroy()
      self._mine_listener = nil
   end

   if self._gather_listener then
      self._gather_listener:destroy()
      self._gather_listener = nil
   end
    
   if self._place_listener then
      self._place_listener:destroy()
      self._place_listener = nil
   end
    
end

function FledglingClass:_on_mine(args)
      self._job_component:add_exp(self._xp_rewards["mine"] or 1)
end

function FledglingClass:_on_place(args)
    if args.structure then
      self._job_component:add_exp(self._xp_rewards["place"] or 5)
    end
end

function FledglingClass:_on_gather(args)
    if args.harvested_target then
        local resource_node = args.harvested_target:get_component('stonehearth:resource_node') 
        if resource_node then
            self._job_component:add_exp(self._xp_rewards["gather"] or 2)
        end 
    end
end

return FledglingClass
