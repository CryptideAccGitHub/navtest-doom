AddCSLuaFile('init.lua') -- for testing purposes
AddCSLuaFile('shared.lua')
include('shared.lua')

--Basic set-up
ENT.ModelTable = {}
ENT.CollisionBounds = Vector(0,0,0)
ENT.StartHealth = 100
ENT.ViewAngle = 180
ENT.Faction = "FACTION_DOOM2016"
ENT.AllowPropDamage = false

ENT.BloodEffect = {"blood_impact_red_01"}

ENT.Possessor_CanBePossessed = true

ENT.tbl_Animations = {}
ENT.tbl_Capabilities = {CAP_OPEN_DOORS}

ENT.ISD2016NPC = true
ENT.t_NextIdleSound = CurTime()+1
ENT.IdleSound = {}

ENT.s_CState = "idle"

function ENT:SetInit()
	self:SetHullType(HULL_HUMAN)
	self:SetMovementType(MOVETYPE_STEP)
	self.s_CState = "idle"
	self.CanWander = false
end

--Schedule processing--------------------------------------------------------------------------------------------

function ENT:HandleSchedules(enemy,dist,nearest,disp,time)
	if self:CanPerformProcess() then
  
		if self.s_CState ~= "idle" and !IsValid(self:GetEnemy()) then
		self.s_CState = "idle"
		end

		if self.s_CState == "idle" then
			if self:GetEnemy() != nil then
				self.CanWander = true
				self.s_CState = "infight"
				return
			end
     
		elseif self.s_CState == "infight" then
		end
    
	end
end
	
function ENT:OnThink()
if CurTime() > self.t_NextIdleSound then
		if math.random(1,6) == 1 then
			sound.Play(self:SelectFromTable(self.IdleSound),self:GetPos())
			self.t_NextIdleSound = CurTime() + math.random(5,8)
		end 
end
end 

function ENT:OnDamage_Pain(dmg,dmginfo,hitbox)
	if math.random(1,2) == 1 && CurTime() > self.NextPainSoundT then
		self.NextPainSoundT = CurTime() + math.Rand(2,3)
	end
end

--Utility code--------------------------------------------------------------------------------------------

function ENT:HandleEvents(...)
	local event = select(1,...)
	local arg1 = select(2,...)
	local rand
	if (event == "emit") then
		if (arg1 == "melee") then
		  self:dCustomMeleeAttack(self:GetAttachment(self:LookupAttachment("origin")).Pos,20,100,90)
		end
	end
	return true
end

function ENT:OnRemove()
end

function ENT:OnDeath(dmg,dmginfo,hitbox)
end
