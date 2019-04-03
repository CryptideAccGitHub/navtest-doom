--[[AddCSLuaFile('init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

ENT.Model = "models/hunter/misc/sphere075x075.mdl"
ENT.v_Goto = self:GetPos()
ENT.Owner = self
ENT.Enemy = nil

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_NONE)
	self:SetModelData()
	self:SetCustomCollisionCheck(true)
  	if IsValid(self:GetOwner()) then
  		self.Owner = self:GetOwner()
  	else
		error(fuck you, how you did it? navigator entity removed because there`s no owner)
		self:Remove()
  	end
end

function ENT:RunBehaviour()
	while (true) do
		if IsValid(self) and IsValid(self.Owner) then
			local Distance = 
			self:Goto()
		end
		coroutine.yield()
	end
end

function ENT:Goto(options)
end

function ENT:IfStuck()
	if IsValid(self) and self.Owner:IsValid() then
		self:SetPos(self.Owner:GetPos() +self.Owner():GetForward() * 30)
	end
end

function ENT:OnKilled()
	self:Remove()
end]]
