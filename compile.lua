local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
local function execute(cmd)
	--print("\n" .. cmd)
	os.execute(cmd)
end

local vproject = os.getenv("vproject")
if not vproject then
	print("vproject not set! aborting")
	os.exit()
end

local start_time = os.time()

execute(vproject .. [[\..\bin\vbsp.exe -notjunc -game "]] .. vproject .. [[" -low "rp_eastcoast_boringbuilders"]])
if file_exists("rp_eastcoast_boringbuilders.lin") then
	print("leak!!!!!!!!")
	os.exit()
end

execute(vproject .. [[\..\bin\vvis.exe -game "]] .. vproject .. [[" -low "rp_eastcoast_boringbuilders"]])

execute(vproject .. [[\..\bin\vrad.exe -game "]] .. vproject .. [[" -low "rp_eastcoast_boringbuilders"]])

local function recurse_and_add(local_path)
	--print("local path", local_path)
	for dir in io.popen([[dir "]] .. local_path .. [[" /b /ad]]):lines() do
		--print("recursing dir", dir)
		recurse_and_add(local_path .. dir .. [[\]])
	end
	for file in io.popen([[dir "]] .. local_path .. [[" /b /a-d]]):lines() do
		--print("adding file", file)
		local file_path = local_path .. file
		execute([[""]] .. vproject .. [[\..\..\Team Fortress 2\bin\bspzip.exe" -addfile rp_eastcoast_boringbuilders.bsp "]] .. file_path .. [[" "]] .. file_path .. [[" rp_eastcoast_boringbuilders.bsp"]])
	end
end
recurse_and_add([[materials\]])
recurse_and_add([[models\]])
execute([[""]] .. vproject .. [[\..\..\Team Fortress 2\bin\bspzip.exe" -repack -compress rp_eastcoast_boringbuilders.bsp"]])

execute([[copy rp_eastcoast_boringbuilders.bsp "]] .. vproject .. [[\maps\rp_eastcoast_boringbuilders.bsp"]])

execute([[copy "rp_eastcoast_boringbuilders.bsp" "workshop\maps\rp_eastcoast_boringbuilders.bsp"]])

local seconds = os.time() - start_time
print(string.format("\nProgram completed in %02d:%02d:%02d.", math.floor(seconds / 60 / 60), math.floor((seconds / 60) % 60), math.floor(seconds % 60)))
os.exit()
