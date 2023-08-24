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
    temp   = {},
    cpu    = {},
    gpu    = {},
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

settings.clock.time_x           = settings.base.x
settings.clock.time_y           = settings.base.y + settings.line.interval * 1.5
settings.clock.date_x           = settings.clock.time_x
settings.clock.date_y           = settings.clock.time_y + 30

settings.info.separator         = settings.clock.date_y + settings.line.section_interval
settings.info.y                 = settings.info.separator + settings.line.section_text_interval
settings.info.y_temp            = settings.info.separator + settings.line.interval
settings.info.y_fan1            = settings.info.y_temp + settings.line.interval
settings.info.y_fan2            = settings.info.y_fan1 + settings.line.interval

settings.temp.y                 = settings.info.y + 85
settings.temp.label             = settings.temp.y + settings.line.section_text_interval
settings.temp.value             = settings.temp.y - settings.line.temp
settings.temp.x1                = settings.base.x - 200
settings.temp.x2                = settings.temp.x1 + 40
settings.temp.x3                = settings.temp.x2 + 40
settings.temp.x4                = settings.temp.x3 + 40
settings.temp.x5                = settings.temp.x4 + 40
settings.temp.label1            = settings.temp.x1 + 12
settings.temp.label2            = settings.temp.x2 + 12
settings.temp.label3            = settings.temp.x3 + 12
settings.temp.label4            = settings.temp.x4 + 12
settings.temp.label5            = settings.temp.x5 + 16
settings.temp.value1            = settings.temp.x1 - 10
settings.temp.value2            = settings.temp.x2 - 10
settings.temp.value3            = settings.temp.x3 - 10
settings.temp.value4            = settings.temp.x4 - 10
settings.temp.value5            = settings.temp.x5 - 10

settings.cpu.separator          = settings.info.y + settings.line.section_interval * 6
settings.cpu.y_util             = settings.cpu.separator + settings.line.interval
settings.cpu.y_info             = settings.cpu.separator + settings.line.section_text_interval

settings.gpu.separator          = settings.cpu.y_util + 11 * settings.line.section_interval
settings.gpu.y_fan              = settings.gpu.separator + settings.line.interval
settings.gpu.y_power            = settings.gpu.y_fan + settings.line.interval
settings.gpu.y_util             = settings.gpu.separator + settings.line.interval
settings.gpu.y_encode           = settings.gpu.y_util + settings.line.interval
settings.gpu.y_ram              = settings.gpu.y_encode + settings.line.interval

settings.mem.separator          = settings.gpu.y_ram + 1 * settings.line.info_height
settings.mem.y_info             = settings.mem.separator + settings.line.section_text_interval
settings.mem.y_ram              = settings.mem.separator + settings.line.interval
settings.mem.y_swap             = settings.mem.y_ram + settings.line.interval
settings.mem.y_usage            = settings.mem.y_swap + settings.line.interval

settings.disk.separator         = settings.mem.y_info + 10 * settings.line.info_height
settings.disk.y_info            = settings.disk.separator + settings.line.section_text_interval
settings.disk.y_ssd_util        = settings.disk.separator + settings.line.interval
settings.disk.y_vdisk_util      = settings.disk.y_ssd_util + settings.line.interval

settings.net.separator          = settings.disk.y_info + 3.5 * settings.line.info_height
settings.net.y_info             = settings.net.separator + settings.line.section_text_interval
settings.net.y_sh1              = settings.net.separator + settings.line.interval * 1.25 -- x 1.25 to vertically center
settings.net.y_sh2              = settings.net.y_sh1 + settings.line.interval
settings.net.y_sh3              = settings.net.y_sh2 + settings.line.interval

settings.server.separator       = settings.net.y_info + 8 * settings.line.info_height
settings.server.y1a             = settings.server.separator + settings.line.interval
settings.server.y1b             = settings.server.y1a + settings.line.interval
settings.server.y2              = settings.server.y1b + settings.line.interval

-- replace the content of the following function to create your own conky theme
function start()
    draw_clock()
    draw_info()
    draw_temp()
    draw_cpu()
    draw_gpu()
    draw_memory()
    draw_disks()
    draw_net()
    draw_server()
end

function draw_clock()
    write(settings.clock.time_x, settings.clock.time_y, time_hrminsec(), 75, main_text_color, "c")
    write(settings.clock.date_x, settings.clock.date_y, string.format("%s, %s %s %s", time_day(), time_month_number(), time_month(), time_year()), 20, main_text_color, "c")
end

function draw_info()
    write_bold(settings.line.endx, settings.info.separator + settings.line.height / 2, "SYSTEM", 12, main_text_color)
    line(settings.line.startx, settings.info.separator, settings.line.endx + 56, settings.info.separator, settings.line.thickness, main_text_color, 1)

    local vals = {
        "Hostname: " .. hostname(),
        "Uptime:   " .. uptime(),
        "Load avg: " .. load_avg(),
        "OS:       " .. os(),
        "Kernel:   " .. kernel(),
        string.format("Desktop:  %s/%s", desktop(), desktops()),
    }
    write_line_by_line(settings.text.endx, settings.info.y, settings.line.info_height, vals, main_text_color, 12, false)
end

function draw_temp()
    local cputemp = math.floor(tonumber(cpu_temperature())/1000)
    local gputemp = tonumber(gpu_temp())
    local ssdtemp = tonumber(ssd_temperature())
    local pchtemp = math.floor(tonumber(sys_temperature())/1000)
    local acpitemp= math.floor(tonumber(acpi_temperature())/1000)

    rectangle_bottomup(settings.temp.x1, settings.temp.y, settings.line.temp, settings.line.thickness, cputemp, 100, color_frompercent(cputemp/100))
    write(settings.temp.value1, settings.temp.value - settings.line.height, cputemp .. "°C", 12, main_text_color)
    write(settings.temp.label1, settings.temp.label - settings.line.height, "CPU", 12, main_text_color, "r")

    rectangle_bottomup(settings.temp.x2, settings.temp.y, settings.line.temp, settings.line.thickness, gputemp, 95, color_frompercent(gputemp/95))
    write(settings.temp.value2, settings.temp.value - settings.line.height, gputemp .. "°C", 12, main_text_color)
    write(settings.temp.label2, settings.temp.label - settings.line.height, "GPU", 12, main_text_color, "r")

    rectangle_bottomup(settings.temp.x3, settings.temp.y, settings.line.temp, settings.line.thickness, pchtemp, 100, color_frompercent(pchtemp/100))
    write(settings.temp.value3, settings.temp.value - settings.line.height, pchtemp .. "°C", 12, main_text_color)
    write(settings.temp.label3, settings.temp.label - settings.line.height, "PCH", 12, main_text_color, "r")

    rectangle_bottomup(settings.temp.x4, settings.temp.y, settings.line.temp, settings.line.thickness, ssdtemp, 86.8, color_frompercent(ssdtemp/86.8))
    write(settings.temp.value4, settings.temp.value - settings.line.height, ssdtemp .. "°C", 12, main_text_color)
    write(settings.temp.label4, settings.temp.label - settings.line.height, "SSD", 12, main_text_color, "r")

    rectangle_bottomup(settings.temp.x5, settings.temp.y, settings.line.temp, settings.line.thickness, acpitemp, 70, color_frompercent(acpitemp/70))
    write(settings.temp.value5, settings.temp.value - settings.line.height, acpitemp .. "°C", 12, main_text_color)
    write(settings.temp.label5, settings.temp.label - settings.line.height, "ACPI", 12, main_text_color, "r")
end

function draw_cpu()
    write_bold(settings.line.endx, settings.cpu.separator + settings.line.height / 2, "CPU: " .. cpu_name(), 12, main_text_color)
    line(settings.line.startx, settings.cpu.separator, settings.line.endx + 308, settings.cpu.separator, settings.line.thickness, main_text_color, 1)

    --local cpufanspeed   = cpu_fanspeed()
    
    --rectangle_rightleft(settings.line.centerxl, settings.cpu.y_fan, settings.line.width_2, settings.line.thickness, cpufanspeed, 1550, color_frompercent(tonumber(cpufanspeed/1550)))
    --write(settings.text.endx, settings.cpu.y_fan - settings.line.height, cpufanspeed .. " RPM", 12, main_text_color)
    --write(settings.text.centerxl, settings.cpu.y_fan - settings.line.height, "CPU fan speed", 12, main_text_color, "r")

    -- processes list by cpu consumption
    write_list_proccesses_cpu(settings.text.endx, settings.cpu.y_info, settings.line.info_height, 10, 12, main_text_color)

    for i = 1, cpu_cores / 2 do
        y = settings.cpu.y_util + (i - 1) * settings.line.interval
        rectangle_rightleft(settings.line.utilxr, y, settings.line.width_4, settings.line.thickness, cpu_percent(i), 100, color_frompercent(tonumber(cpu_percent(i))))
    end
    for i = 1, cpu_cores / 2 do
        y = settings.cpu.y_util + (i - 1) * settings.line.interval
        rectangle_rightleft(settings.line.startx, y, settings.line.width_4, settings.line.thickness, cpu_percent(i + cpu_cores / 2), 100, color_frompercent(tonumber(cpu_percent(i + cpu_cores / 2))))
    end

    -- values
    for i = 1, cpu_cores / 2 do
        y = settings.cpu.y_util + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.utilxl, y, cpu_percent(i) .. "%", 12, main_text_color)
    end
    for i = 1, cpu_cores / 2 do
        y = settings.cpu.y_util + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.centerxr, y, cpu_percent(i + cpu_cores / 2) .. "%", 12, main_text_color)
    end

    -- titles
    for i = 1, cpu_cores / 2 do
        y = settings.cpu.y_util + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.utilxr, y, cpu_freq(i) .. " MHz", 12, main_text_color, "r")
    end
    for i = 1, cpu_cores / 2 do
        y = settings.cpu.y_util + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.startx, y, cpu_freq(i + cpu_cores / 2) .. " MHz", 12, main_text_color, "r")
    end
end

function draw_gpu()
    write_bold(settings.line.endx, settings.gpu.separator + settings.line.height / 2, "GPU: " .. gpu_name(), 12, main_text_color)
    line(settings.line.startx, settings.gpu.separator, settings.line.endx + 180, settings.gpu.separator, settings.line.thickness, main_text_color, 1)

    local gpufan    = gpu_fanspeed()
    local gpupower  = gpu_power()
    local gpuutil   = gpu_utilization()
    local gpuram    = gpu_vram_util()
    local gpuencode = gpu_encode()

    rectangle_rightleft(settings.line.centerxl, settings.gpu.y_fan, settings.line.width_2, settings.line.thickness, gpufan, 100, color_frompercent(tonumber(gpufan)))
    write(settings.text.endx, settings.gpu.y_fan - settings.line.height, gpufan .. "%", 12, main_text_color)
    write(settings.text.centerxl, settings.gpu.y_fan - settings.line.height, "Fan speed", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.centerxl, settings.gpu.y_power, settings.line.width_2, settings.line.thickness, gpupower, 75, color_frompercent(tonumber(gpupower)/75))
    write(settings.text.endx, settings.gpu.y_power - settings.line.height, gpupower .. "W", 12, main_text_color)
    write(settings.text.centerxl, settings.gpu.y_power - settings.line.height, "Power usage", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.gpu.y_util, settings.line.width_2, settings.line.thickness, gpuutil, 100, color_frompercent(tonumber(gpuutil)))
    write(settings.text.centerxr, settings.gpu.y_util - settings.line.height, tonumber(gpuutil) .. "%", 12, main_text_color)
    write(settings.text.startx, settings.gpu.y_util - settings.line.height, "GPU-Util", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.gpu.y_encode, settings.line.width_2, settings.line.thickness, gpuencode, 95, color_frompercent(tonumber(gpuencode)))
    write(settings.text.centerxr, settings.gpu.y_encode - settings.line.height, gpuencode .. "%", 12, main_text_color)
    write(settings.text.startx, settings.gpu.y_encode - settings.line.height, "Encode-Util", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.gpu.y_ram, settings.line.width_2, settings.line.thickness, gpuram, 4096, color_frompercent(tonumber(gpuram)/4096))
    write(settings.text.centerxr, settings.gpu.y_ram - settings.line.height, math.floor(tonumber(gpuram)/4096*100) .. " %", 12, main_text_color)
    write(settings.text.startx, settings.gpu.y_ram - settings.line.height, "RAM:" .. gpuram .. "MiB", 12, main_text_color, "r")
end

function draw_memory()
    write_bold(settings.line.endx, settings.mem.separator + settings.line.height / 2, "MEMORY", 12, main_text_color)
    line(settings.line.startx, settings.mem.separator, settings.line.endx + 52, settings.mem.separator, settings.line.thickness, main_text_color, 1)

    -- processes list by mem consumption
    write_list_proccesses_mem(settings.text.endx, settings.mem.y_info, settings.line.info_height, 10, 12, main_text_color)

    local memperc  = memory_percent()
    local swapperc = swap_percent()
    local mem      = string.format("RAM: %s / %s", memory(), memory_max())
    local swp      = string.format("Swap: %s / %s", swap(), swap_max())

    rectangle_rightleft(settings.line.startx, settings.mem.y_ram, settings.line.width_2, settings.line.thickness, memperc, 100, color_frompercent(tonumber(memperc)))
    write(settings.text.centerxr, settings.mem.y_ram - settings.line.height, memperc .. "%", 12, main_text_color)
    write(settings.text.startx, settings.mem.y_ram - settings.line.height, mem, 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.mem.y_swap, settings.line.width_2, settings.line.thickness, swapperc, 100, color_frompercent(tonumber(swapperc)))
    write(settings.text.centerxr, settings.mem.y_swap - settings.line.height, swapperc .. "%", 12, main_text_color)
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
    write_bold(settings.line.endx, settings.disk.separator + settings.line.height / 2, "DRIVES", 12, main_text_color)
    line(settings.line.startx, settings.disk.separator, settings.line.endx + 52, settings.disk.separator, settings.line.thickness, main_text_color, 1)

    -- info
    local vals = {
        "Disk I/O:   " .. diskio("/dev/sda"),
        "  Read:     " .. diskio_read("/dev/sda"),
        "  Write:    " .. diskio_write("/dev/sda"),
    }
    write_line_by_line(settings.text.endx, settings.disk.y_info, settings.line.info_height, vals, main_text_color, 12, false)

    local root_used = tonumber(pve_root_used())
    local root_size = tonumber(pve_root_size())
    local stor_size = tonumber(pve_store_size())
    local stor_used = tonumber(pve_store_used()) * stor_size / 100

    local root          = string.format("SSD: %s / %s", math.floor(root_used + stor_used) .. "GiB", math.floor(root_size + stor_size) .. "GiB")
    local rootperc      = math.floor((root_used + stor_used) / (root_size + stor_size) * 100)
    local vm            = string.format("/dev/sda: %s / %s", fs_used("/"), fs_size("/"))
    local vmperc        = tonumber(fs_used_perc("/"))

    rectangle_rightleft(settings.line.startx, settings.disk.y_ssd_util, settings.line.width_5, settings.line.thickness, rootperc, 100, color_frompercent(rootperc))
    write(settings.text.midxl, settings.disk.y_ssd_util - settings.line.height, rootperc .. "%", 12, main_text_color)
    write(settings.text.startx, settings.disk.y_ssd_util - settings.line.height, root, 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.disk.y_vdisk_util, settings.line.width_5, settings.line.thickness, vmperc, 100, color_frompercent(vmperc))
    write(settings.text.midxl, settings.disk.y_vdisk_util - settings.line.height, vmperc .. "%", 12, main_text_color)
    write(settings.text.startx, settings.disk.y_vdisk_util - settings.line.height, vm, 12, main_text_color, "r")
end

function draw_net()
    write_bold(settings.line.endx, settings.net.separator + settings.line.height / 2, "NETWORK", 12, main_text_color)
    line(settings.line.startx, settings.net.separator, settings.line.endx + 60, settings.net.separator, settings.line.thickness, main_text_color, 1)

    -- info
    local vals = {
        "Net speed:",
        "  Down:     " .. download_speed(),
        "  Up:       " .. upload_speed(),
        "Total down: " .. download_total(),
        "Total up:   " .. upload_total(),
    }
    if use_public_ip then
        table.insert(vals, "Public IP: " .. public_ip)
        table.insert(vals, "VPN IP:    " .. vpn_ip)
    end
    table.insert(vals, "Local IP:  " .. local_ip())
    write_line_by_line(settings.text.endx, settings.net.y_info, settings.line.info_height, vals, main_text_color, 12, false)

    local jodibooks     = string.format("jodibooks-share: %s / %s", fs_used("/media/jodibooks-share"), fs_size("/media/jodibooks-share"))
    local joediapna     = string.format("joediapna-share: %s / %s", fs_used("/media/joediapna-share"), fs_size("/media/joediapna-share"))
    local user          = string.format("user-share: %s / %s", fs_used("/media/joep"), fs_size("/media/joep"))
    local jodibooksperc = fs_used_perc("/media/jodibooks-share")
    local joediapnaperc = fs_used_perc("/media/joediapna-share")
    local userperc      = fs_used_perc("/media/joep")

    rectangle_rightleft(settings.line.startx, settings.net.y_sh1, settings.line.width_5, settings.line.thickness, jodibooksperc, 100, color_frompercent(tonumber(jodibooksperc)))
    rectangle_rightleft(settings.line.startx, settings.net.y_sh2, settings.line.width_5, settings.line.thickness, joediapnaperc, 100, color_frompercent(tonumber(joediapnaperc)))
    rectangle_rightleft(settings.line.startx, settings.net.y_sh3, settings.line.width_5, settings.line.thickness, userperc, 100, color_frompercent(tonumber(userperc)))

    -- values
    write(settings.text.midxl, settings.net.y_sh1 - settings.line.height, jodibooksperc .. "%", 12, main_text_color)
    write(settings.text.midxl, settings.net.y_sh2 - settings.line.height, joediapnaperc .. "%", 12, main_text_color)
    write(settings.text.midxl, settings.net.y_sh3 - settings.line.height, userperc .. "%", 12, main_text_color)

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
    local cputemp2   = dell_cpu_temp("10.33.10.101", "ipmi_user", "fwCX4MCvjz3N5mRRtUBx")
    local inlettemp1 = hp_inlet_temp("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9")
    local inlettemp2 = dell_inlet_temp("10.33.10.101", "ipmi_user", "fwCX4MCvjz3N5mRRtUBx")
    local fanspeed1a = hp_fan_speed("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9", "'Fan 1'")
    local fanspeed1b = hp_fan_speed("10.33.10.100", "ipmi_user", "pBjwGJ6Z9MD7msBV8Ym9", "'Fan 3'")
    local fanspeed2  = tonumber(dell_fan_speed("10.33.10.101", "ipmi_user", "fwCX4MCvjz3N5mRRtUBx", "'Sys Fan1'")) or 0

    rectangle_rightleft(settings.line.leftxr, settings.server.y1a, settings.line.width_3, settings.line.thickness, inlettemp1, 40, color_frompercent(tonumber(inlettemp1/40)))

    rectangle_rightleft(settings.line.leftxr, settings.server.y2, settings.line.width_3, settings.line.thickness, inlettemp2, 40, color_frompercent(tonumber(inlettemp2/40)))

    rectangle_rightleft(settings.line.midxr, settings.server.y1a, settings.line.width_3, settings.line.thickness, cputemp1a, 75, color_frompercent(tonumber(cputemp1a/70)))
    rectangle_rightleft(settings.line.midxr, settings.server.y1b, settings.line.width_3, settings.line.thickness, cputemp1b, 75, color_frompercent(tonumber(cputemp1b/70)))
    rectangle_rightleft(settings.line.midxr, settings.server.y2, settings.line.width_3, settings.line.thickness, cputemp2, 75, color_frompercent(tonumber(cputemp2/70)))

    rectangle_rightleft(settings.line.startx, settings.server.y1a, settings.line.width_3, settings.line.thickness, fanspeed1a, 100, color_frompercent(fanspeed1a))
    rectangle_rightleft(settings.line.startx, settings.server.y1b, settings.line.width_3, settings.line.thickness, fanspeed1b, 100, color_frompercent(fanspeed1b))
    rectangle_rightleft(settings.line.startx, settings.server.y2, settings.line.width_3, settings.line.thickness, fanspeed2, 6400, color_frompercent(fanspeed2/6400))

    -- values
    write(settings.text.endx, settings.server.y1a - settings.line.height, inlettemp1 .. "°C", 12, main_text_color)
    write(settings.text.endx, settings.server.y2 - settings.line.height, inlettemp2 .. "°C", 12, main_text_color)

    write(settings.text.midxl, settings.server.y1a - settings.line.height, cputemp1a .. "°C", 12, main_text_color)
    write(settings.text.midxl, settings.server.y1b - settings.line.height, cputemp1b .. "°C", 12, main_text_color)
    write(settings.text.midxl, settings.server.y2 - settings.line.height, cputemp2 .. "°C", 12, main_text_color)

    write(settings.text.rightxl, settings.server.y1a - settings.line.height, math.floor(fanspeed1a/100*8750) .. " RPM", 12, main_text_color)
    write(settings.text.rightxl, settings.server.y1b - settings.line.height, math.floor(fanspeed1b/100*8750) .. " RPM", 12, main_text_color)
    write(settings.text.rightxl, settings.server.y2 - settings.line.height, math.floor(fanspeed2) .. " RPM", 12, main_text_color)

    -- titles
    write(settings.text.leftxr, settings.server.y1a - settings.line.height, "Inlet temp. SRV1", 12, main_text_color, "r")
    write(settings.text.leftxr, settings.server.y2 - settings.line.height, "Inlet temp. SRV2", 12, main_text_color, "r")

    write(settings.text.midxr, settings.server.y1a - settings.line.height, "CPU1 SRV1 temp.", 12, main_text_color, "r")
    write(settings.text.midxr, settings.server.y1b - settings.line.height, "CPU2 SRV1 temp.", 12, main_text_color, "r")
    write(settings.text.midxr, settings.server.y2 - settings.line.height, "CPU SRV2 temp.", 12, main_text_color, "r")

    write(settings.text.startx, settings.server.y1a - settings.line.height, "SRV1 fan speed", 12, main_text_color, "r")
    write(settings.text.startx, settings.server.y1b - settings.line.height, "SRV1 fan speed", 12, main_text_color, "r")
    write(settings.text.startx, settings.server.y2 - settings.line.height, "SRV2 fan speed", 12, main_text_color, "r")
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
            if vpn_ip == nil or vpn_ip == "None" or (number_updates%public_ip_refresh_rate) == 0 then
                vpn_ip = fetch_vpn_ip()
            end
        end

        start()
    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
