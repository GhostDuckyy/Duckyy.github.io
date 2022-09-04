local request = (syn and syn.request) or (http and http.request) or request or http_request or nil
getgenv().source = nil

while task.wait() do
    if request ~= nil then
        getgenv().source = request({Url = "https://raw.githubusercontent.com/GhostDuckyy/Taurus/main/Loader.lua",Method = "GET"})
        if getgenv().source.Success == true then break; end
    else
        break;
    end
end

if getgenv().source ~= nil and getgenv().source.Body then
    loadstring(getgenv().source.Body)()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Taurus/main/Loader.lua",true))()
end
