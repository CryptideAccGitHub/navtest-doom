--Actual stuff
ENT.Base = "npc_cpt_base"
ENT.PrintName = ""
ENT.Information	= "Small enemy, easily killable and not dangerous."

--Unused stuff
ENT.Type = "ai"
ENT.PrintName = ""
ENT.Author = "REXMaster"
ENT.Contact = "Me" 
ENT.Purpose = ""
ENT.Instructions = "Rip and tear"
ENT.Category = "DOOM (2016)"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:InitShared()
language.Add(self:GetClass(), self.PrintName)
killicon.Add(self:GetClass(),"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..self:GetClass(), self.PrintName)
killicon.Add("#"..self:GetClass(),"HUD/killicons/default",Color(255,80,0,255))
end
