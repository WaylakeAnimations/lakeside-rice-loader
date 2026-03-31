Name = "lakeside-rice-loader"
NamePretty = "Lakeside Rice Loader"
HideFromProviderlist = false
Action = "%VALUE%"
HideFromProviderlist = false
SearchName = true
FixedOrder = true
History = false
Cache=false

function GetEntries()
    local home_dir = os.getenv("HOME")
    local entries = {}

    table.insert(entries, {
        Text = "Back",
        Value = "walker --provider menus:lake-personal-menu --hideqa -N",
        Subtext = "Lake's Personal Menu"
    })

    local theme_dir = home_dir .. "/.local/share/lakeside-rice-loader/rice-sets/"
    local handle = io.popen("find '" ..
        theme_dir ..
        "' -maxdepth 1 -name '*' 2>/dev/null")
    if handle then
        for line in handle:lines() do
            local filename = line:match("([^/]+)$")
            if filename then

                package.path = home_dir .. "/.config/elephant/lunajson/?.lua;" .. package.path
                local lunajson = require("lunajson")
                local file = io.open(line .. "/rice.json", "r")
                local content = file:read("*a")
                local rice_set_metadata = lunajson.decode(content)

                if file then
                    table.insert(entries, {
                        Text = filename,
                        Subtext = (rice_set_metadata.description),
                        Value = "bash ~/.local/share/lakeside-rice-loader/lsrl.sh " .. filename,
                        Icon = line .. "/wallpaper/static.png"
                    })
                    file:close()
                end
            end
        end
        handle:close()
    end
    return entries
end