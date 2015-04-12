if SERVER then
	AddCSLuaFile("f4base/cl_init.lua")
	AddCSLuaFile("f4base/cl_frame.lua")
	AddCSLuaFile("f4base/cl_example.lua")
else
	include("f4base/cl_init.lua")
end