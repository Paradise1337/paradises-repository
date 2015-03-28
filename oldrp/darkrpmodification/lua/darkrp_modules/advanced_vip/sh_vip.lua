/*AdvancedVIP = {}
AdvancedVIP.save = {
	folder = "advancedvip",
	filename_v = "vip",
	filename_sv = "super_vip"
}
local vip_path = AdvancedVIP.save["folder"].."/"..AdvancedVIP.save["filename_v"]..".txt"
local svip_path = AdvancedVIP.save["folder"].."/"..AdvancedVIP.save["filename_sv"]..".txt"

function AdvancedVIP:Initialize()
	if (!file.IsDir(AdvancedVIP.save["folder"], "DATA")) then
		Msg("[AdvancedVIP] Creating folder...\n")
		file.CreateDir(AdvancedVIP.save["folder"])
		Msg("[AdvancedVIP] Folder is succesfull created!\n")
	end

	if (!file.Exists(vip_path, "DATA")) then file.Write(vip_path, "") end
	if (!file.Exists(svip_path, "DATA")) then file.Write(svip_path, "") end
end

function AdvancedVIP:AddVip(ply, time)
	if self:CheckPly(ply, "vip") then return end
	local _data = file.Read(vip_path, "DATA")
	local data = {}
	if _data != "" then
		data = pon.decode(_data)
	end
	local t = math.Round(SysTime()) + time
	data[ply:SteamID()] = {ply:SteamID(), math.Round(SysTime()), t}
	_data = pon.encode(data)
	file.Write(vip_path, _data)
	Msg("New VIP player has been added to list on "..time.." seconds, ID - "..ply:SteamID().."\n")
end

function AdvancedVIP:DelVip(stid)
	if self:CheckPly(stid, "vip", true) then return end
	local _data = file.Read(vip_path, "DATA")
	local data = {}
	if _data != "" then
		data = pon.decode(_data)
	end

	data[stid] = nil

	_data = pon.encode(data)
	file.Write(vip_path, _data)
	Msg("Player "..stid.." has been removed from vip\n")
end

function AdvancedVIP:AddSuperVip(ply, time)
	if self:CheckPly(ply, "svip") then return end
	local _data = file.Read(svip_path, "DATA")
	local data = {}
	if _data != "" then
		data = pon.decode(_data)
	end
	local t = math.Round(SysTime()) + time
	data[ply:SteamID()] = {ply:SteamID(), math.Round(SysTime()), t}
	_data = pon.encode(data)
	file.Write(svip_path, _data)
	Msg("New SuperVIP player has been added to list on "..time.." seconds, ID - "..ply:SteamID().."\n")
end

function AdvancedVIP:DelSuperVip(stid)
	if self:CheckPly(stid, "svip", true) then return end
	local _data = file.Read(svip_path, "DATA")
	local data = {}
	if _data != "" then
		data = pon.decode(_data)
	end

	data[stid] = nil

	_data = pon.encode(data)
	file.Write(svip_path, _data)
	Msg("Player "..stid.." has been removed from super vip\n")
end

function AdvancedVIP:CheckPly(ply, list, bool)
	if bool then
		if list == "vip" then
			local _data = file.Read(vip_path, "DATA")
			if _data == "" then
				return false
			else
				_data = pon.decode(_data)
				if _data[ply] then
					return true
				else
					return false
				end
			end
		elseif list == "svip" then
			local _data = file.Read(svip_path, "DATA")
			if _data == "" then
				return false
			else
				_data = pon.decode(_data)
				if IsValid(_data[ply]) then
					return true
				else
					return false
				end
			end
		end
		return false
	end

	if list == "vip" then
		local _data = file.Read(vip_path, "DATA")
		if _data == "" then
			return false
		else
			_data = pon.decode(_data)
			if _data[ply:SteamID()] then
				return true
			else
				return false
			end
		end
	elseif list == "svip" then
		local _data = file.Read(svip_path, "DATA")
		if _data == "" then
			return false
		else
			_data = pon.decode(_data)
			if IsValid(_data[ply:SteamID()]) then
				return true
			else
				return false
			end
		end
	end

	return true
end

if SERVER then
	AdvancedVIP:Initialize()
	concommand.Add("TestVip", function(ply)
		AdvancedVIP:AddVip(ply, 60)
	end)

	concommand.Add("CheckVip", function(ply)
		print(AdvancedVIP:CheckPly(ply, "vip"))
	end)
end*/

do --- PLAYER META
	local meta = FindMetaTable("Player")
	function meta:IsVIP()
		return self:GetUserGroup() == "vip" and true or self:GetUserGroup() == "supervip" and true or self:IsAdmin() and true or false
	end

	function meta:IsSuperVIP()
		return self:GetUserGroup() == "supervip" and true or self:IsAdmin() and true or false
	end
end