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
    clock  = {},
    info   = {},
    cpu    = {},
    mem    = {},
    disk   = {},
    net    = {},
    server = {},
}

settings.base.margin            = 16
settings.base.x                 = 600 -- this should be conky.config.minimum_width + 8
settings.base.y                 = 40

-- 2 colums
-- ===============   ===============
-- endx - centerxl - centerxr - startx
-- 3 colums
-- =============   =============   =============
-- endx - leftxr - midxl - midxr - rightxl - startx

settings.line.thickness         = 2
settings.line.height            = 10
settings.line.info_height       = 20
settings.line.width_2           = (settings.base.x - 3 * settings.base.margin) / 2 -- line lenght (2 columns)
settings.line.width_3           = (settings.base.x - 4 * settings.base.margin) / 3 -- line lenght (3 columns)
settings.line.startx            = settings.base.x - settings.base.margin           -- right
settings.line.centerxr          = settings.line.startx - settings.line.width_2     -- right of center; left of the right column (2 columns)
settings.line.centerxl          = settings.line.centerxr - settings.base.margin    -- left of center; right of the left column (2 columns)
settings.line.endx              = settings.base.margin                             -- left
settings.line.rightxl           = settings.line.startx - settings.line.width_3     -- left of the right column (3 columns)
settings.line.midxr             = settings.line.rightxl - settings.base.margin     -- right of the mid column (3 columns)
settings.line.midxl             = settings.line.midxr - settings.line.width_3      -- left of the mid column (3 columns)
settings.line.leftxr            = settings.line.midxl - settings.base.margin       -- right of the left column (3 columns)
settings.line.interval          = 40
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

settings.clock.time_x           = settings.base.x
settings.clock.time_y           = settings.base.y + settings.line.interval * 1.5
settings.clock.date_x           = settings.clock.time_x
settings.clock.date_y           = settings.clock.time_y + 30

settings.info.separator         = settings.clock.date_y + settings.line.section_interval
settings.info.y                 = settings.info.separator + settings.line.section_text_interval
settings.info.y_temp            = settings.info.separator + settings.line.interval
settings.info.y_fan1            = settings.info.y_temp + settings.line.interval
settings.info.y_fan2            = settings.info.y_fan1 + settings.line.interval

settings.cpu.separator          = settings.info.y_fan2 + settings.line.section_interval
settings.cpu.y_temp             = settings.cpu.separator + settings.line.interval
settings.cpu.y_fan              = settings.cpu.y_temp + settings.line.interval
settings.cpu.y_load             = settings.cpu.y_fan + settings.line.section_text_interval
settings.cpu.y_info             = settings.cpu.y_load + settings.line.interval * 0.75

settings.mem.separator          = settings.cpu.y_info + 10 * settings.line.info_height
settings.mem.y_info             = settings.mem.separator + settings.line.section_text_interval
settings.mem.y_ram              = settings.mem.separator + settings.line.interval
settings.mem.y_swap             = settings.mem.y_ram + settings.line.interval
settings.mem.y_usage            = settings.mem.y_swap + settings.line.interval

settings.disk.separator         = settings.mem.y_info + 10 * settings.line.info_height
settings.disk.y_info            = settings.disk.separator + settings.line.section_text_interval
settings.disk.y_ssd             = settings.disk.separator + settings.line.interval * 1.25 -- x 1.25 to vertically center

settings.net.separator          = settings.disk.y_info + 3 * settings.line.info_height
settings.net.y_info             = settings.net.separator + settings.line.section_text_interval
settings.net.y_sh1              = settings.net.separator + settings.line.interval * 1.25 -- x 1.25 to vertically center
settings.net.y_sh2              = settings.net.y_sh1 + settings.line.interval
settings.net.y_sh3              = settings.net.y_sh2 + settings.line.interval

settings.server.separator       = settings.net.y_info + 7 * settings.line.info_height
settings.server.y_inlet         = settings.server.separator + settings.line.interval
settings.server.y_temp1a        = settings.server.y_inlet + settings.line.interval
settings.server.y_temp1b        = settings.server.y_temp1a + settings.line.interval
settings.server.y_temp2         = settings.server.y_temp1b + settings.line.interval
settings.server.y_temp3         = settings.server.y_temp2 + settings.line.interval
settings.server.y_fan1a         = settings.server.y_inlet + settings.line.interval
settings.server.y_fan1b         = settings.server.y_fan1a + settings.line.interval
settings.server.y_fan2          = settings.server.y_fan1b + settings.line.interval
settings.server.y_fan3          = settings.server.y_fan2 + settings.line.interval

-- replace the content of the following function to create your own conky theme
function start()
    draw_clock()
    draw_info()
    draw_cpu()
    draw_memory()
    draw_disks()
    draw_net()
    draw_server()
end

function draw_clock()
    write(settings.clock.time_x, settings.clock.time_y, time_hrminsec(), 85, main_text_color, "c")
    write(settings.clock.date_x, settings.clock.date_y, string.format("%s, %s %s %s", time_day(), time_month_number(), time_month(), time_year()), 20, main_text_color, "c")
end

function draw_info()
    write_bold(settings.line.endx, settings.info.separator + settings.line.height / 2, "SYSTEM", 12, main_text_color)
    line(settings.line.startx, settings.info.separator, settings.line.endx + 56, settings.info.separator, settings.line.thickness, main_text_color, 1)

    local vals = {
        "Hostname:  " .. hostname(),
        "Uptime:    " .. uptime(),
        "OS:        " .. os(),
        "Kernel:    " .. kernel(),
        string.format("Desktop:   %s/%s", desktop(), desktops()),
    }
    write_line_by_line(settings.text.endx, settings.info.y, settings.line.info_height, vals, main_text_color, 12, false)

    local systemp   = sys_temperature()
    --local sysfan1   = sys_fanspeed1()
    --local sysfan2   = sys_fanspeed2()

    rectangle_rightleft(settings.line.startx, settings.info.y_temp, settings.line.width_2, settings.line.thickness, systemp, 70, color_frompercent(tonumber(systemp/70)))
    --rectangle_rightleft(settings.line.startx, settings.info.y_fan1, settings.line.width_2, settings.line.thickness, sysfan1, 1150, color_frompercent(tonumber(sysfan1/1150)))
    --rectangle_rightleft(settings.line.startx, settings.info.y_fan2, settings.line.width_2, settings.line.thickness, sysfan2, 1250, color_frompercent(tonumber(sysfan2/1250)))

    -- values
    write(settings.text.centerxr, settings.info.y_temp - settings.line.height, systemp .. "°C", 12, main_text_color)
    --write(settings.text.centerxr, settings.info.y_fan1 - settings.line.height, sysfan1 .. " RPM", 12, main_text_color)
    --write(settings.text.centerxr, settings.info.y_fan2 - settings.line.height, sysfan2 .. " RPM", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.info.y_temp - settings.line.height, "System temperature", 12, main_text_color, "r")
    --write(settings.text.startx, settings.info.y_fan1 - settings.line.height, "System fan 1 speed", 12, main_text_color, "r")
    --write(settings.text.startx, settings.info.y_fan2 - settings.line.height, "System fan 2 speed", 12, main_text_color, "r")
end

function draw_cpu()
    write_bold(settings.line.endx, settings.cpu.separator + settings.line.height / 2, "CPU", 12, main_text_color)
    line(settings.line.startx, settings.cpu.separator, settings.line.endx + 32, settings.cpu.separator, settings.line.thickness, main_text_color, 1)

    -- cpu info
    local vals = {
        "Load avg: " .. load_avg(),
    }
    write_line_by_line(settings.text.endx, settings.cpu.y_load, settings.line.info_height, vals, main_text_color, 12, false)
    -- processes list by cpu consumption
    write_list_proccesses_cpu(settings.text.endx, settings.cpu.y_info, settings.line.info_height, 10, 12, main_text_color)

    local cputemp       = cpu_temperature()
    local cpufanspeed   = cpu_fanspeed()

    rectangle_rightleft(settings.line.centerxl, settings.cpu.y_temp, settings.line.width_2, settings.line.thickness, cputemp, 70, color_frompercent(tonumber(cputemp/70)))
    rectangle_rightleft(settings.line.centerxl, settings.cpu.y_fan, settings.line.width_2, settings.line.thickness, cpufanspeed, 1550, color_frompercent(tonumber(cpufanspeed/1550)))
    for i = 1, cpu_cores do
        y = settings.cpu.y_temp + (i - 1) * settings.line.interval
        rectangle_rightleft(settings.line.startx, y, settings.line.width_2, settings.line.thickness, cpu_percent(i), 100, color_frompercent(tonumber(cpu_percent(i))))
    end
    --rectangle_rightleft(settings.line.startx, settings.cpu.y_total, settings.line.width_2, settings.line.thickness, cpu, 100, color_frompercent(tonumber(cpu)))

    -- values
    write(settings.text.endx, settings.cpu.y_temp - settings.line.height, cputemp .. "°C", 12, main_text_color)
    write(settings.text.endx, settings.cpu.y_fan - settings.line.height, cpufanspeed .. " RPM", 12, main_text_color)
    for i = 1, cpu_cores do
        y = settings.cpu.y_temp + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.centerxr, y, cpu_percent(i) .. "%", 12, main_text_color)
    end
    --write(settings.text.centerxr, settings.cpu.y_total - settings.line.height, cpu .. "%", 12, main_text_color)

    -- titles
    write(settings.text.centerxl, settings.cpu.y_temp - settings.line.height, "CPU temperature", 12, main_text_color, "r")
    write(settings.text.centerxl, settings.cpu.y_fan - settings.line.height, "CPU fan speed", 12, main_text_color, "r")
    for i = 1, cpu_cores do
        y = settings.cpu.y_temp + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.startx, y, "CPU " .. i .. ": " .. cpu_freq(i) .. " MHz", 12, main_text_color, "r")
    end
    --write(settings.text.startx, settings.cpu.y_total - settings.line.height, "total CPU", 12, main_text_color, "r")
end

function draw_memory()
    write_bold(settings.line.endx, settings.mem.separator + settings.line.height / 2, "MEMORY", 12, main_text_color)
    line(settings.line.startx, settings.mem.separator, settings.line.endx + 56, settings.mem.separator, settings.line.thickness, main_text_color, 1)

    -- processes list by mem consumption
    write_list_proccesses_mem(settings.text.endx, settings.mem.y_info, settings.line.info_height, 10, 12, main_text_color)

    local memperc  = memory_percent()
    local swapperc = swap_percent()
    local mem      = string.format("RAM: %s / %s", memory(), memory_max())
    local swp      = string.format("Swap: %s / %s", swap(), swap_max())

    rectangle_rightleft(settings.line.startx, settings.mem.y_ram, settings.line.width_2, settings.line.thickness, memperc, 100, color_frompercent(tonumber(memperc)))
    rectangle_rightleft(settings.line.startx, settings.mem.y_swap, settings.line.width_2, settings.line.thickness, swapperc, 100, color_frompercent(tonumber(swapperc)))

    -- values
    write(settings.text.centerxr, settings.mem.y_ram - settings.line.height, memperc .. "%", 12, main_text_color)
    write(settings.text.centerxr, settings.mem.y_swap - settings.line.height, swapperc .. "%", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.mem.y_ram - settings.line.height, mem, 12, main_text_color, "r")
    write(settings.text.startx, settings.mem.y_swap - settings.line.height, swp, 12, main_text_color, "r")

    -- mem info
    local vals = {
        "Usage memory:",
        "  Total:    " .. memory_max(),
        "  Buffered: " .. memory_buffers(),
        "  Cached:   " .. memory_cached(),
        "  Used:     " .. memory(),
    }
    write_line_by_line(settings.text.centerxr, settings.mem.y_usage, settings.line.info_height, vals, main_text_color, 12, false)
end

function draw_disks()
    write_bold(settings.line.endx, settings.disk.separator + settings.line.height / 2, "FILE SYSTEMS", 12, main_text_color)
    line(settings.line.startx, settings.disk.separator, settings.line.endx + 96, settings.disk.separator, settings.line.thickness, main_text_color, 1)

    -- info
    local vals = {
        "Disk I/O:  " .. diskio("/dev/sda"),
        "  Read:    " .. diskio_read("/dev/sda"),
        "  Write:   " .. diskio_write("/dev/sda"),
    }
    write_line_by_line(settings.text.endx, settings.disk.y_info, settings.line.info_height, vals, main_text_color, 12, false)

    --local ssdtemp       = ssd_temperature()
    local root          = string.format("SSD: %s / %s", fs_used("/"), fs_size("/"))
    local rootperc      = fs_used_perc("/")

    rectangle_rightleft(settings.line.startx, settings.disk.y_ssd, settings.line.width_2, settings.line.thickness, rootperc, 100, color_frompercent(tonumber(rootperc)))

    -- values
    write(settings.text.centerxr, settings.disk.y_ssd - settings.line.height, rootperc .. "%", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.disk.y_ssd - settings.line.height, root, 12, main_text_color, "r")
end

function draw_net()
    write_bold(settings.line.endx, settings.net.separator + settings.line.height / 2, "NETWORK", 12, main_text_color)
    line(settings.line.startx, settings.net.separator, settings.line.endx + 60, settings.net.separator, settings.line.thickness, main_text_color, 1)

    -- info
    local vals = {
        "Net speed:",
        "  Download:     " .. download_speed(),
        "  Upload:       " .. upload_speed(),
        "Total download: " .. download_total(),
        "Total upload:   " .. upload_total(),
    }
    if use_public_ip then
        table.insert(vals, "Public IP: " .. public_ip)
    end
    table.insert(vals, "Local IP:  " .. local_ip())
    write_line_by_line(settings.text.endx, settings.net.y_info, settings.line.info_height, vals, main_text_color, 12, false)

    local jodibooks     = string.format("jodibooks-share: %s / %s", fs_used("/media/jodibooks-share"), fs_size("/media/jodibooks-share"))
    local joediapna     = string.format("joediapna-share: %s / %s", fs_used("/media/joediapna-share"), fs_size("/media/joediapna-share"))
    local user          = string.format("user-share: %s / %s", fs_used("/media/joep"), fs_size("/media/joep"))
    local jodibooksperc = fs_used_perc("/media/jodibooks-share")
    local joediapnaperc = fs_used_perc("/media/joediapna-share")
    local userperc      = fs_used_perc("/media/joep")

    rectangle_rightleft(settings.line.startx, settings.net.y_sh1, settings.line.width_2, settings.line.thickness, jodibooksperc, 100, color_frompercent(tonumber(jodibooksperc)))
    rectangle_rightleft(settings.line.startx, settings.net.y_sh2, settings.line.width_2, settings.line.thickness, joediapnaperc, 100, color_frompercent(tonumber(joediapnaperc)))
    rectangle_rightleft(settings.line.startx, settings.net.y_sh3, settings.line.width_2, settings.line.thickness, userperc, 100, color_frompercent(tonumber(userperc)))

    -- values
    write(settings.text.centerxr, settings.net.y_sh1 - settings.line.height, jodibooksperc .. "%", 12, main_text_color)
    write(settings.text.centerxr, settings.net.y_sh2 - settings.line.height, joediapnaperc .. "%", 12, main_text_color)
    write(settings.text.centerxr, settings.net.y_sh3 - settings.line.height, userperc .. "%", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.net.y_sh1 - settings.line.height, jodibooks, 12, main_text_color, "r")
    write(settings.text.startx, settings.net.y_sh2 - settings.line.height, joediapna, 12, main_text_color, "r")
    write(settings.text.startx, settings.net.y_sh3 - settings.line.height, user, 12, main_text_color, "r")
end

function draw_server()
    write_bold(settings.line.endx, settings.server.separator + settings.line.height / 2, "SERVERS", 12, main_text_color)
    line(settings.line.startx, settings.server.separator, settings.line.endx + 56, settings.server.separator, settings.line.thickness, main_text_color, 1)

    local cputemp1a  = hp_cpu1_temp("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9")
    local cputemp1b  = hp_cpu2_temp("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9")
    local cputemp2  = dell_cpu_temp("10.33.10.101", "ipmi_user", "fwCX4MCvjz3N5mRRtUBx")
    local cputemp3  = dell_cpu_temp("10.33.10.102", "ipmi_user", "dY9ZR9b6w5yqq5BY39g2")
    local inlettemp1  = hp_inlet_temp("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9")
    local inlettemp2  = dell_inlet_temp("10.33.10.101", "ipmi_user", "fwCX4MCvjz3N5mRRtUBx")
    local inlettemp3  = dell_inlet_temp("10.33.10.102", "ipmi_user", "dY9ZR9b6w5yqq5BY39g2")
    local fanspeed1a  = hp_fan_speed("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9", "'Fan 1'")
    local fanspeed1b  = hp_fan_speed("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9", "'Fan 3'")
    local fanspeed2  = dell_fan_speed("10.33.10.101", "ipmi_user", "fwCX4MCvjz3N5mRRtUBx", "'Sys Fan1'")
    local fanspeed3  = dell_fan_speed("10.33.10.102", "ipmi_user", "dY9ZR9b6w5yqq5BY39g2", "Fan2A")

    rectangle_rightleft(settings.line.leftxr, settings.server.y_inlet, settings.line.width_3, settings.line.thickness, inlettemp1, 40, color_frompercent(tonumber(inlettemp1/40)))
    rectangle_rightleft(settings.line.midxr, settings.server.y_inlet, settings.line.width_3, settings.line.thickness, inlettemp2, 40, color_frompercent(tonumber(inlettemp2/40)))
    rectangle_rightleft(settings.line.startx, settings.server.y_inlet, settings.line.width_3, settings.line.thickness, inlettemp3, 40, color_frompercent(tonumber(inlettemp3/40)))

    rectangle_rightleft(settings.line.centerxl, settings.server.y_temp1a, settings.line.width_2, settings.line.thickness, cputemp1a, 70, color_frompercent(tonumber(cputemp1a/70)))
    rectangle_rightleft(settings.line.centerxl, settings.server.y_temp1b, settings.line.width_2, settings.line.thickness, cputemp1b, 70, color_frompercent(tonumber(cputemp1b/70)))
    rectangle_rightleft(settings.line.centerxl, settings.server.y_temp2, settings.line.width_2, settings.line.thickness, cputemp2, 70, color_frompercent(tonumber(cputemp2/70)))
    rectangle_rightleft(settings.line.centerxl, settings.server.y_temp3, settings.line.width_2, settings.line.thickness, cputemp3, 70, color_frompercent(tonumber(cputemp3/70)))

    --rectangle_rightleft(settings.line.startx, settings.server.y_fan1a, settings.line.width_2, settings.line.thickness, fanspeed1a/100, 5700, color_frompercent(fanspeed1a))
    --rectangle_rightleft(settings.line.startx, settings.server.y_fan1b, settings.line.width_2, settings.line.thickness, fanspeed1b/100, 5700, color_frompercent(fanspeed1b))
    rectangle_rightleft(settings.line.startx, settings.server.y_fan2, settings.line.width_2, settings.line.thickness, fanspeed2, 5700, color_frompercent(tonumber(fanspeed2/5700)))
    rectangle_rightleft(settings.line.startx, settings.server.y_fan3, settings.line.width_2, settings.line.thickness, fanspeed3, 19885, color_frompercent(tonumber(fanspeed3/19885)))

    -- values
    write(settings.text.endx, settings.server.y_inlet - settings.line.height, inlettemp1 .. "°C", 12, main_text_color)
    write(settings.text.midxl, settings.server.y_inlet - settings.line.height, inlettemp2 .. "°C", 12, main_text_color)
    write(settings.text.rightxl, settings.server.y_inlet - settings.line.height, inlettemp3 .. "°C", 12, main_text_color)

    write(settings.text.endx, settings.server.y_temp1a - settings.line.height, cputemp1a .. "°C", 12, main_text_color)
    write(settings.text.endx, settings.server.y_temp1b - settings.line.height, cputemp1b .. "°C", 12, main_text_color)
    write(settings.text.endx, settings.server.y_temp2 - settings.line.height, cputemp2 .. "°C", 12, main_text_color)
    write(settings.text.endx, settings.server.y_temp3 - settings.line.height, cputemp3 .. "°C", 12, main_text_color)

    write(settings.text.centerxr, settings.server.y_fan1a - settings.line.height, fanspeed1a .. " %", 12, main_text_color)
    write(settings.text.centerxr, settings.server.y_fan1b - settings.line.height, fanspeed1b .. " %", 12, main_text_color)
    write(settings.text.centerxr, settings.server.y_fan2 - settings.line.height, tonumber(math.floor(fanspeed2/5700*100)) .. " %", 12, main_text_color)
    write(settings.text.centerxr, settings.server.y_fan3 - settings.line.height, tonumber(math.floor(fanspeed3/19885*100)) .. " %", 12, main_text_color)

    -- titles
    write(settings.text.leftxr, settings.server.y_inlet - settings.line.height, "Inlet temp. SRV1", 12, main_text_color, "r")
    write(settings.text.midxr, settings.server.y_inlet - settings.line.height, "Inlet temp. SRV2", 12, main_text_color, "r")
    write(settings.text.startx, settings.server.y_inlet - settings.line.height, "Inlet temp. SRV3", 12, main_text_color, "r")

    write(settings.text.centerxl, settings.server.y_temp1a - settings.line.height, "CPU1 SRV1 temperature", 12, main_text_color, "r")
    write(settings.text.centerxl, settings.server.y_temp1b - settings.line.height, "CPU2 SRV1 temperature", 12, main_text_color, "r")
    write(settings.text.centerxl, settings.server.y_temp2 - settings.line.height, "CPU SRV2 temperature", 12, main_text_color, "r")
    write(settings.text.centerxl, settings.server.y_temp3 - settings.line.height, "CPU SRV3 temperature", 12, main_text_color, "r")

    write(settings.text.startx, settings.server.y_fan1a - settings.line.height, "SRV1 fan setting", 12, main_text_color, "r")
    write(settings.text.startx, settings.server.y_fan1b - settings.line.height, "SRV1 fan setting", 12, main_text_color, "r")
    write(settings.text.startx, settings.server.y_fan2 - settings.line.height, "SRV2 fan setting", 12, main_text_color, "r")
    write(settings.text.startx, settings.server.y_fan3 - settings.line.height, "SRV3 fan setting", 12, main_text_color, "r")
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

    local number_updates = tonumber(updates())
    if number_updates > time_before_start then
        if use_public_ip then
            if public_ip == nil or public_ip == "None" or (number_updates%public_ip_refresh_rate) == 0 then
                public_ip = fetch_public_ip()
            end
        end

        start()
    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
