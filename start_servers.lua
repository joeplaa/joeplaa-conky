----------------------------------
-- Author:      Zineddine SAIBI
-- Software:    Pomaria-Side
-- Type:        Conky Theme
-- License:     GPL-3.0
-- repository:  https://www.github.com/SZinedine/pomaria-side
----------------------------------

require 'abstract'

settings = {
    base   = {},
    line   = {},
    text   = {},
    vert   = {},
    circ   = {},
    info   = {},
    temps  = {},
    fans   = {},
    power  = {},
}

settings.base.margin            = 16
settings.base.x                 = 600 -- this should be conky.config.minimum_width + 8
settings.base.y                 = 40

-- 2 colums
-- ===============   =================
-- endx - centerxl - centerxr - startx
-- 3 colums
-- =============   =============   ================
-- endx - leftxr - midxl - midxr - rightxl - startx
-- 4 colums
-- =============   =============   =================   ===============
--                               - centerxr - utilxr - utilxl - startx

settings.line.thickness         = 2
settings.line.height            = 10
settings.line.info_height       = 20
settings.line.temp              = 80
settings.line.width_2           = (settings.base.x - 3 * settings.base.margin) / 2 -- line length (2 columns)
settings.line.width_3           = (settings.base.x - 4 * settings.base.margin) / 3 -- line length (3 columns)
settings.line.width_4           = (settings.base.x - 5 * settings.base.margin) / 4 -- line length (4 columns)
settings.line.width_5           = settings.line.width_3 * 2 + settings.base.margin -- line length (2/3 width)
settings.line.startx            = settings.base.x - settings.base.margin           -- right
settings.line.centerxr          = settings.line.startx - settings.line.width_2     -- right of center; left of the right column (2 columns)
settings.line.centerxl          = settings.line.centerxr - settings.base.margin    -- left of center; right of the left column (2 columns)
settings.line.endx              = settings.base.margin                             -- left
settings.line.rightxl           = settings.line.startx - settings.line.width_3     -- left of the right column (3 columns)
settings.line.midxr             = settings.line.rightxl - settings.base.margin     -- right of the mid column (3 columns)
settings.line.midxl             = settings.line.midxr - settings.line.width_3      -- left of the mid column (3 columns)
settings.line.leftxr            = settings.line.midxl - settings.base.margin       -- right of the left column (3 columns)
settings.line.utilxl            = settings.line.startx - settings.line.width_4     -- left of the right column (4 columns)
settings.line.utilxr            = settings.line.utilxl - settings.base.margin      -- right of the mid column (4 columns)
settings.line.interval          = 40
settings.line.radius            = 25
settings.line.section_interval  = settings.line.interval * 0.5
settings.line.section_text_interval = settings.line.interval * 0.75

settings.text.startx            = settings.line.startx - settings.base.margin / 2   -- right
settings.text.centerxr          = settings.line.centerxr + settings.base.margin / 2 -- right of center; left of the right column (2 columns)
settings.text.centerxl          = settings.line.centerxl - settings.base.margin / 2 -- left of center; right of the left column (2 columns)
settings.text.endx              = settings.line.endx + settings.base.margin / 2     -- left
settings.text.rightxl           = settings.line.rightxl + settings.base.margin / 2  -- left of the right column (3 columns)
settings.text.midxr             = settings.line.midxr - settings.base.margin / 2    -- right of the mid column (3 columns)
settings.text.midxl             = settings.line.midxl + settings.base.margin / 2    -- left of the mid column (3 columns)
settings.text.leftxr            = settings.line.leftxr - settings.base.margin / 2   -- right of the left column (3 columns)
settings.text.utilxl            = settings.line.utilxl + settings.base.margin / 2   -- left of the right column (4 columns)
settings.text.utilxr            = settings.line.utilxr - settings.base.margin / 2   -- right of the mid column (4 columns)

settings.vert.x1                = settings.base.x - 280
settings.vert.x2                = settings.vert.x1 + 45
settings.vert.x3                = settings.vert.x2 + 45
settings.vert.x4                = settings.vert.x3 + 45
settings.vert.x5                = settings.vert.x4 + 45
settings.vert.label1            = settings.vert.x1 + 16
settings.vert.label2            = settings.vert.x2 + 16
settings.vert.label3            = settings.vert.x3 + 16
settings.vert.label4            = settings.vert.x4 + 16
settings.vert.label5            = settings.vert.x5 + 16
settings.vert.value1            = settings.vert.x1 - 12
settings.vert.value2            = settings.vert.x2 - 12
settings.vert.value3            = settings.vert.x3 - 12
settings.vert.value4            = settings.vert.x4 - 12
settings.vert.value5            = settings.vert.x5 - 12

settings.circ.x                 = settings.base.x - 48
settings.circ.value             = settings.base.x + settings.circ.x - 44

settings.info.x                 = settings.base.x
settings.info.y                 = settings.base.y + settings.line.interval * 1.25
settings.info.separator1        = settings.info.y + settings.line.interval
settings.info.values1           = settings.info.separator1 + settings.line.section_text_interval
settings.info.separator2        = settings.info.values1 + settings.line.section_interval * 6.5
settings.info.values2           = settings.info.separator2 + settings.line.section_text_interval
settings.info.separator3        = settings.info.values2 + settings.line.section_interval * 6.5
settings.info.values3           = settings.info.separator3 + settings.line.section_text_interval
settings.info.separator4        = settings.info.values3 + settings.line.section_interval * 6.5
settings.info.values4           = settings.info.separator4 + settings.line.section_text_interval

settings.temps.y1               = settings.info.separator1 + 120
settings.temps.label1           = settings.temps.y1 + settings.line.section_text_interval
settings.temps.value1           = settings.temps.y1 - settings.line.temp
settings.temps.y2               = settings.info.separator2 + 120
settings.temps.label2           = settings.temps.y2 + settings.line.section_text_interval
settings.temps.value2           = settings.temps.y2 - settings.line.temp
settings.temps.y3               = settings.info.separator3 + 120
settings.temps.label3           = settings.temps.y3 + settings.line.section_text_interval
settings.temps.value3           = settings.temps.y3 - settings.line.temp
settings.temps.y4               = settings.info.separator4 + 120
settings.temps.label4           = settings.temps.y4 + settings.line.section_text_interval
settings.temps.value4           = settings.temps.y4 - settings.line.temp

settings.fans.y1_1              = settings.info.separator1 + 50
settings.fans.value1_1          = settings.fans.y1_1 + 16
settings.fans.y1_2              = settings.fans.y1_1 + 64
settings.fans.value1_2          = settings.fans.y1_2 + 16
settings.fans.y2_1              = settings.info.separator2 + 50
settings.fans.value2_1          = settings.fans.y2_1 + 16
settings.fans.y2_2              = settings.fans.y2_1 + 64
settings.fans.value2_2          = settings.fans.y2_2 + 16
settings.fans.y3_1              = settings.info.separator3 + 50
settings.fans.value3_1          = settings.fans.y3_1 + 16
settings.fans.y3_2              = settings.fans.y3_1 + 64
settings.fans.value3_2          = settings.fans.y3_2 + 16

settings.power.separator        = settings.info.values3 + settings.line.section_interval * 6.5
settings.power.total            = settings.power.separator + settings.line.section_text_interval
settings.power.y1               = settings.temps.y1
settings.power.label1           = settings.temps.label1
settings.power.value1           = settings.temps.value1
settings.power.y2               = settings.temps.y2
settings.power.label2           = settings.temps.label2
settings.power.value2           = settings.temps.value2
settings.power.y3               = settings.temps.y3
settings.power.label3           = settings.temps.label3
settings.power.value3           = settings.temps.value3
settings.power.y4               = settings.temps.y4
settings.power.label4           = settings.temps.label4
settings.power.value4           = settings.temps.value4

-- replace the content of the following function to create your own conky theme
function start()
    draw_info()
    draw_temps()
    draw_fanspeeds()
    draw_power()
end

function draw_info()
    write(settings.info.x, settings.info.y, "SERVERS", 56, main_text_color, "c")

    write_bold(settings.line.endx, settings.info.separator1 + settings.line.height / 2, "S4", 12, main_text_color)
    line(settings.line.startx, settings.info.separator1, settings.line.endx + 24, settings.info.separator1, settings.line.thickness, main_text_color, 1)
    local vals = {
        "Hostname: " .. server_hostname("jpl-proxmox4"),
        "Uptime:   " .. server_uptime("jpl-proxmox4"),
        "OS:       " .. server_os("jpl-proxmox4"),
        "Kernel:   " .. server_kernel("jpl-proxmox4"),
        "IPMI IP:  10.33.10.103",
        "OS IP:    10.33.60.114",
    }
    write_line_by_line(settings.text.endx, settings.info.values1, settings.line.info_height, vals, main_text_color, 12, false)

    write_bold(settings.line.endx, settings.info.separator2 + settings.line.height / 2, "S5", 12, main_text_color)
    line(settings.line.startx, settings.info.separator2, settings.line.endx + 24, settings.info.separator2, settings.line.thickness, main_text_color, 1)
    local vals = {
        "Hostname: " .. server_hostname("jpl-proxmox5"),
        "Uptime:   " .. server_uptime("jpl-proxmox5"),
        "OS:       " .. server_os("jpl-proxmox5"),
        "Kernel:   " .. server_kernel("jpl-proxmox5"),
        "IPMI IP:  10.33.10.104",
        "OS IP:    10.33.60.115",
    }
    write_line_by_line(settings.text.endx, settings.info.values2, settings.line.info_height, vals, main_text_color, 12, false)

    write_bold(settings.line.endx, settings.info.separator3 + settings.line.height / 2, "S6", 12, main_text_color)
    line(settings.line.startx, settings.info.separator3, settings.line.endx + 24, settings.info.separator3, settings.line.thickness, main_text_color, 1)
    local vals = {
        "Hostname: " .. server_hostname("jpl-proxmox6"),
        "Uptime:   " .. server_uptime("jpl-proxmox6"),
        "OS:       " .. server_os("jpl-proxmox6"),
        "Kernel:   " .. server_kernel("jpl-proxmox6"),
        "IPMI IP:  10.33.10.105",
        "OS IP:    10.33.60.116",
    }
    write_line_by_line(settings.text.endx, settings.info.values3, settings.line.info_height, vals, main_text_color, 12, false)
end

function draw_temps()
    local max_inlet = 40
    local max_cpu = 75
    local max_pch = 95

    local cputemp4   = hp_cpu1_temp("10.33.10.103", "ipmi_user", "E77tnDFzx53c99ESD6m6")
    local cputemp5a  = hp_cpu1_temp("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2")
    local cputemp5b  = hp_cpu2_temp("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2")
    local cputemp6   = sm_cpu_temp("10.33.10.105", "ipmi_user", "Epmxd4LR8jbh6oJ4mpy")
    local inlettemp4 = hp_inlet_temp("10.33.10.103", "ipmi_user", "E77tnDFzx53c99ESD6m6")
    local inlettemp5 = hp_inlet_temp("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2")
    local pchtemp4   = hp_pch_temp("10.33.10.103", "ipmi_user", "E77tnDFzx53c99ESD6m6")
    local pchtemp5   = hp_pch_temp("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2")
    local pchtemp6   = sm_pch_temp("10.33.10.105", "ipmi_user", "Epmxd4LR8jbh6oJ4mpy")

    -- Inlet temps
    rectangle_bottomup(settings.vert.x1, settings.temps.y1, settings.line.temp, settings.line.thickness, inlettemp4, max_inlet, color_frompercent(inlettemp4/max_inlet))
    write(settings.vert.value1, settings.temps.value1 - settings.line.height, inlettemp4 .. "°C", 12, main_text_color)
    write(settings.vert.label1 - 8, settings.temps.label1 - settings.line.height, "IN", 12, main_text_color, "r")

    rectangle_bottomup(settings.vert.x1, settings.temps.y2, settings.line.temp, settings.line.thickness, inlettemp5, max_inlet, color_frompercent(inlettemp5/max_inlet))
    write(settings.vert.value1, settings.temps.value2 - settings.line.height, inlettemp5 .. "°C", 12, main_text_color)
    write(settings.vert.label1 - 8, settings.temps.label2 - settings.line.height, "IN", 12, main_text_color, "r")

    -- CPU temps
    rectangle_bottomup(settings.vert.x2, settings.temps.y1, settings.line.temp, settings.line.thickness, cputemp4, max_cpu, color_frompercent(cputemp4/max_cpu))
    write(settings.vert.value2, settings.temps.value1 - settings.line.height, cputemp4 .. "°C", 12, main_text_color)
    write(settings.vert.label2, settings.temps.label1 - settings.line.height, "CPU1", 12, main_text_color, "r")

    rectangle_bottomup(settings.vert.x2, settings.temps.y2, settings.line.temp, settings.line.thickness, cputemp5a, max_cpu, color_frompercent(cputemp5a/max_cpu))
    write(settings.vert.value2, settings.temps.value2 - settings.line.height, cputemp5a .. "°C", 12, main_text_color)
    write(settings.vert.label2, settings.temps.label2 - settings.line.height, "CPU1", 12, main_text_color, "r")

    rectangle_bottomup(settings.vert.x3, settings.temps.y2, settings.line.temp, settings.line.thickness, cputemp5b, max_cpu, color_frompercent(cputemp5b/max_cpu))
    write(settings.vert.value3, settings.temps.value2 - settings.line.height, cputemp5b .. "°C", 12, main_text_color)
    write(settings.vert.label3, settings.temps.label2 - settings.line.height, "CPU2", 12, main_text_color, "r")

    rectangle_bottomup(settings.vert.x1, settings.temps.y3, settings.line.temp, settings.line.thickness, cputemp6, max_cpu, color_frompercent(cputemp6/max_cpu))
    write(settings.vert.value1, settings.temps.value3 - settings.line.height, cputemp6 .. "°C", 12, main_text_color)
    write(settings.vert.label1 - 4, settings.temps.label3 - settings.line.height, "CPU", 12, main_text_color, "r")

    -- PCH temps
    rectangle_bottomup(settings.vert.x3, settings.temps.y1, settings.line.temp, settings.line.thickness, pchtemp4, max_pch, color_frompercent(pchtemp4/max_pch))
    write(settings.vert.value3, settings.temps.value1 - settings.line.height, pchtemp4 .. "°C", 12, main_text_color)
    write(settings.vert.label3 - 4, settings.temps.label1 - settings.line.height, "PCH", 12, main_text_color, "r")

    rectangle_bottomup(settings.vert.x4, settings.temps.y2, settings.line.temp, settings.line.thickness, pchtemp5, max_pch, color_frompercent(pchtemp5/max_pch))
    write(settings.vert.value4, settings.temps.value2 - settings.line.height, pchtemp5 .. "°C", 12, main_text_color)
    write(settings.vert.label4 - 4, settings.temps.label2 - settings.line.height, "PCH", 12, main_text_color, "r")

    rectangle_bottomup(settings.vert.x2, settings.temps.y3, settings.line.temp, settings.line.thickness, pchtemp6, max_pch, color_frompercent(pchtemp6/max_pch))
    write(settings.vert.value2, settings.temps.value3 - settings.line.height, pchtemp6 .. "°C", 12, main_text_color)
    write(settings.vert.label2 - 4, settings.temps.label3 - settings.line.height, "PCH", 12, main_text_color, "r")
end

function draw_fanspeeds()
    local max_hpdl380g9_fan_speed = 16500 -- Delta PFR0612XHE https://www.delta-fan.com/pfr0612xhe.html
    local max_hpml350g9_fan_speed = 11500 -- Delta PFR0912XHE https://www.delta-fan.com/products/pfr0912xhe-sp00.html
    local max_sm_fan_speed = 1600

    local fanspeed4a = hp_fan_speed("10.33.10.103", "ipmi_user", "E77tnDFzx53c99ESD6m6", "'Fan 3'")
    local fanspeed4b = hp_fan_speed("10.33.10.103", "ipmi_user", "E77tnDFzx53c99ESD6m6", "'Fan 6'")
    local fanspeed5a = hp_fan_speed("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2", "'Fan 1'")
    local fanspeed5b = hp_fan_speed("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2", "'Fan 5'")
    local fanspeed6  = sm_fan_speed("10.33.10.105", "ipmi_user", "Epmxd4LR8jbh6oJ4mpy", "'FAN1'")

    ring_clockwise(settings.circ.x, settings.fans.y1_1, settings.line.radius, settings.line.thickness, 0, 360, fanspeed4a, 100, color_frompercent(fanspeed4a))
    write(settings.circ.value - 6, settings.fans.value1_1 - settings.line.height, math.floor(fanspeed4a/100*max_hpdl380g9_fan_speed), 12, main_text_color, "c")

    ring_clockwise(settings.circ.x, settings.fans.y1_2, settings.line.radius, settings.line.thickness, 0, 360, fanspeed4b, 100, color_frompercent(fanspeed4b))
    write(settings.circ.value - 6, settings.fans.value1_2 - settings.line.height, math.floor(fanspeed4b/100*max_hpdl380g9_fan_speed), 12, main_text_color, "c")

    ring_clockwise(settings.circ.x, settings.fans.y2_1, settings.line.radius, settings.line.thickness, 0, 360, fanspeed5a, 100, color_frompercent(fanspeed5a))
    write(settings.circ.value - 6, settings.fans.value2_1 - settings.line.height, math.floor(fanspeed5a/100*max_hpml350g9_fan_speed), 12, main_text_color, "c")

    ring_clockwise(settings.circ.x, settings.fans.y2_2, settings.line.radius, settings.line.thickness, 0, 360, fanspeed5b, 100, color_frompercent(fanspeed5b))
    write(settings.circ.value - 6, settings.fans.value2_2 - settings.line.height, math.floor(fanspeed5b/100*max_hpml350g9_fan_speed), 12, main_text_color, "c")

    ring_clockwise(settings.circ.x, settings.fans.y3_1, settings.line.radius, settings.line.thickness, 0, 360, fanspeed6, max_sm_fan_speed, color_frompercent(fanspeed6/max_sm_fan_speed))
    write(settings.circ.value - 6, settings.fans.value3_1 - settings.line.height, math.floor(fanspeed6), 12, main_text_color, "c")
end

function draw_power()
    write_bold(settings.line.endx, settings.power.separator + settings.line.height / 2, "POWER USAGE [W]", 12, main_text_color)
    line(settings.line.startx, settings.power.separator, settings.line.endx + 120, settings.power.separator, settings.line.thickness, main_text_color, 1)

    local max_hpdl380g9_power = 1000
    local max_hpml350g9_power = 1000
    -- local max_sm_power = 550

    local power4 = hp_pwr("10.33.10.103", "ipmi_user", "E77tnDFzx53c99ESD6m6")
    local power5 = hp_pwr("10.33.10.104", "ipmi_user", "rktmwwtLdeDk4YtWGQg2")

    write(settings.line.endx, settings.power.total + settings.line.height / 2, "Total power use: " .. power4 + power5 .. ' + ???', 12, main_text_color)

    rectangle_bottomup(settings.vert.x5, settings.power.y1, settings.line.temp, settings.line.thickness, power4, max_hpdl380g9_power, color_frompercent(power4/max_hpdl380g9_power))
    write(settings.vert.value5 - 4, settings.power.value1 - settings.line.height, power4 .. " W", 12, main_text_color)
    write(settings.vert.label5 - 12, settings.power.label1 - settings.line.height, "⚡", 16, main_text_color, "r")

    rectangle_bottomup(settings.vert.x5, settings.power.y2, settings.line.temp, settings.line.thickness, power5, max_hpml350g9_power, color_frompercent(power5/max_hpml350g9_power))
    write(settings.vert.value5 - 4, settings.power.value2 - settings.line.height, power5 .. " W", 12, main_text_color)
    write(settings.vert.label5 - 12, settings.power.label2 - settings.line.height, "⚡", 16, main_text_color, "r")
end

function conky_main()
    if conky_window == nil then
        return
    elseif colors_defined == false then
        io.stderr:write("Fatal Error. Please define a theme")
    end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable,
                                         conky_window.visual, conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

    start()

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
