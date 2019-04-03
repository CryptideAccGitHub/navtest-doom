function ENT:dCDamage(pos,damage,dist,angle,dmgtype)
	local _pos = pos or self:GetPos() +self:OBBCenter() +self:GetForward() *20
	local _dmg = damage or 20
	local _dist = dist or 100
	local _angle = angle or 90
	local _dmgtype = dmgtype or DMG_SLASH
	local diff = math.Round(GetConVar("cpt_aidifficulty"):GetInt())
	local didhit = false
	if diff == 0 then diff = 1 end
	for _,v in ipairs(ents.FindInSphere(_pos,_dist)) do
		if !IsValid(v) then return end
		if self:FindInCone(v,_ang) then
			if v:GetClass() != "npc_turret_floor" then
				local dmg = DamageInfo()
				if v:IsPlayer() then
					v:ViewPunch(Angle(math.random(-1,1)*damage/3,math.random(-1,1)*damage/3,math.random(-1,1)*damage/3))
					dmg:SetDamage(_dmg*diff/2)
				elseif v:IsNPC() then
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
		didhit = true
		end
	end
	if didhit then 
		sound.Play(self.CurrentHitSound,_pos)
	else
		sound.Play(self.CurrentMissSound,_pos)
	end
end

unction ENT:dCAngleTo(pos)
	local targetang = (pos - self:GetPos() +self:OBBCenter()):Angle()
	local _x = math.AngleDifference(targetang.x,self:GetAngles().x)
	local _y = math.AngleDifference(targetang.y,self:GetAngles().y)
	local _return = {["x"] = _x,["y"] = _y}
	return _return
end

function ENT:dCResetBoneAngles()
local _bone = self:LookupBone(bone)
self:ManipulateBoneAngles(_bone,Angle(-self:ManipulateBoneAngles().x,-self:ManipulateBoneAngles().y,0) )
end

function ENT:dCLook(bone, pos, limitx, limity, speed, mul)
	local mul = mul or 1
	local _bone = self:LookupBone(bone)
	local selfpos = self:GetPos() +self:OBBCenter()
	local selfang = self:GetAngles()
	local targetang = (pos - selfpos):Angle()
	local x = math.AngleDifference(targetang.x,selfang.x)*mul
	local y = math.AngleDifference(targetang.y,selfang.y)*mul
	local returnx = Lerp(0.5,self:GetManipulateBoneAngles(_bone).x,math.Approach(self:GetManipulateBoneAngles(_bone).x,x,speed))
	local returny = Lerp(0.5,self:GetManipulateBoneAngles(_bone).y,math.Approach(self:GetManipulateBoneAngles(_bone).y,y,speed))
	
	if (x > -limitx and x < limitx) and (y > -limity and y < limity) then
		if self:GetManipulateBoneAngles().x ~= returnx and self:GetManipulateBoneAngles().y ~= returny then
			self:ManipulateBoneAngles(_bone,Angle(returnx,returny,0) )
		end
	end
end
