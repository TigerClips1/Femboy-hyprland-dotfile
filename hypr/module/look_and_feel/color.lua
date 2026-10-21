-- Border colors and background. look_and_feel.lua is loaded afterwards and overrides these.
hl.config({
        general = {
            border_size = 2,
            gaps_in = 5,
            gaps_out = 10,
        col = {
           
            active_border = "rgb(ff0000)", "rgb(ffff00)",  "rgb(00ff00)", "rgb(00ffff)" ,"rgb(0000ff)", "rgb(ff00ff)", "rgb(ff0000)", "0deg",
            inactive_border = "rgba(595959aa)",
            layout = dwindle,
        },
    },
    misc = {
        background_color = "rgba(121318FF)",
    },
})

hl.window_rule({ -- not sure how to syntax "pin 1"
    match        = { pin = 1 },
    border_color = "rgba(afc6ffAA) rgba(afc6ff77)",
})