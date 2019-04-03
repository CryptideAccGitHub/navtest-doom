function ENT:dCDamage(pos,damage,dist,angle,dmgtype)
	local _pos = pos or self:GetPos() +self:OBBCenter() +self:GetForward() *20
	local _dmg = damage or 20
	local _dist = dist or 100
	local _angle = angle or 90
  local _dmgtype = dmgtype or DMG_SLASH
  local diff = math.Round(GetConVar("cpt_aidifficulty"):GetInt())
  if diff == 0 then diff = 1 end
	for _,v in ipairs(ents.FindInSphere(_pos,_dist)) do
    if !IsValid(v) then return end
    if self:FindInCone(v,_ang) then
				if v:GetClass() != "npc_turret_floor" then
					local dmg = DamageInfo()
					if v:IsPlayer() then
						v:ViewPunch(Angle(math.random(-1,1)*damage/3,math.random(-1,1)*damage/3,math.random(-1,1)*damage/3))
						dmg:SetDamage(_dmg*diff/2)
					elseif self:GetHitEntity():IsNPC() then
						dmg:SetDamage(_dmg*diff/2*3)
					end
					dmg:SetAttacker(self)
					dmg:SetInflictor(self)
					dmg:SetDamagePosition(v:NearestPoint(self:GetPos()+self:OBBCenter()))
					dmg:SetDamageType(_dmgtype)
					v:TakeDamageInfo(dmg)
				else
							ent:Fire("selfdestruct","",0)
							ent:GetPhysicsObject():ApplyForceCenter(self:GetForward()*1000)
				end
    end
	end
end
