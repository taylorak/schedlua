local Queue = require('schedlua.queue');

local PriorityQueue = {};

setmetatable(PriorityQueue, {
  __call = function(self, ...)
    return self:init(...);
  end,
  __index = Queue
})

local PriorityQueue_mt = {
  __index = PriorityQueue;
}

PriorityQueue.init = function(self)
  local obj = {
    first = 1,
    last = 0,
  };

  setmetatable(obj, PriorityQueue_mt);

  return obj;
end

function PriorityQueue:enqueue(task)

  local index = self.last;

  if self.first > self.last then
    self.last = self.last + 1;
    self[self.last] = task;
  else
    -- for x=self.last,self.first,-1 do
    while index >= self.first do
      if task.Priority < self[index].Priority then
        self[index+1] = self[index];
      else
        break;
      end
      index = index - 1;
    end
    self.last = self.last + 1;
    self[index + 1] = task;
  end

  return task;
end

return PriorityQueue
