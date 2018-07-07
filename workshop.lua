local function execute(cmd)
	--print("\n" .. cmd)
	os.execute(cmd)
end

local vproject = os.getenv("vproject")
if not vproject then
	print("vproject not set! aborting")
	os.exit()
end

execute(vproject .. [[\..\bin\gmad.exe create -folder "workshop" -out "rp_eastcoast_boringbuilders.gma"]])

execute(vproject .. [[\..\bin\gmpublish.exe update -addon "rp_eastcoast_boringbuilders.gma" -id "1433810310"]])

os.exit()
