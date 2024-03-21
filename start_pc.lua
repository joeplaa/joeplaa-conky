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
    gpu1   = {},
    gpu2   = {},
    mem    = {},
    data   = {},
    server = {},
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
settings.clock.time_y           = settings.base.y + settings.line.interval
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
settings.temp.x1                = settings.base.x - 220
settings.temp.x2                = settings.temp.x1 + 45
settings.temp.x3                = settings.temp.x2 + 45
settings.temp.x4                = settings.temp.x3 + 45
settings.temp.x5                = settings.temp.x4 + 45
settings.temp.label1            = settings.temp.x1 + 12
settings.temp.label2            = settings.temp.x2 + 16
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

settings.gpu1.separator         = settings.cpu.y_util + 11 * settings.line.section_interval
settings.gpu1.y_fan             = settings.gpu1.separator + settings.line.interval
settings.gpu1.y_power           = settings.gpu1.y_fan + settings.line.interval
settings.gpu1.y_ram             = settings.gpu1.y_power + settings.line.interval
settings.gpu1.y_util            = settings.gpu1.separator + settings.line.interval
settings.gpu1.y_decode          = settings.gpu1.y_util + settings.line.interval
settings.gpu1.y_encode          = settings.gpu1.y_decode + settings.line.interval

settings.mem.separator          = settings.gpu1.y_encode + settings.line.info_height
settings.mem.y_info             = settings.mem.separator + settings.line.section_text_interval
settings.mem.y_ram              = settings.mem.separator + settings.line.interval
settings.mem.y_swap             = settings.mem.y_ram + settings.line.interval
settings.mem.y_usage            = settings.mem.y_swap + settings.line.interval

settings.data.separator         = settings.mem.y_info + 10 * settings.line.info_height
settings.data.y_info_net        = settings.data.separator + settings.line.section_text_interval
settings.data.y_ssd_util        = settings.data.separator + settings.line.interval
settings.data.y_sh1             = settings.data.y_ssd_util + settings.line.interval
settings.data.y_sh2             = settings.data.y_sh1 + settings.line.interval
settings.data.y_sh3             = settings.data.y_sh2 + settings.line.interval
settings.data.y_speed_read      = settings.data.y_sh3 + settings.line.interval
settings.data.y_speed_write     = settings.data.y_speed_read + settings.line.interval
settings.data.y_speed_down      = settings.data.y_sh3 + settings.line.interval
settings.data.y_speed_up        = settings.data.y_speed_down + settings.line.interval

settings.server.separator       = settings.data.y_speed_up + 1.5 * settings.line.info_height
settings.server.y1a             = settings.server.separator + settings.line.interval
settings.server.y1b             = settings.server.y1a + settings.line.interval
settings.server.y2              = settings.server.y1b + settings.line.interval

-- replace the content of the following function to create your own conky theme
function start()
    draw_clock()
    draw_info()
    draw_temp()
    draw_cpu()
    draw_gpu1()
    draw_memory()
    draw_data()
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
    local cputemp  = tonumber(cpu_temperature())
    local gpu1temp = tonumber(gpu_temp(1))
    local ssdtemp  = tonumber(ssd_temperature())
    local pchtemp  = tonumber(pch_temperature())
    local acpitemp = tonumber(acpi_temperature())

    rectangle_bottomup(settings.temp.x1, settings.temp.y, settings.line.temp, settings.line.thickness, cputemp, 100, color_frompercent(cputemp/100))
    write(settings.temp.value1, settings.temp.value - settings.line.height, cputemp .. "°C", 12, main_text_color)
    write(settings.temp.label1, settings.temp.label - settings.line.height, "CPU", 12, main_text_color, "r")

    rectangle_bottomup(settings.temp.x2, settings.temp.y, settings.line.temp, settings.line.thickness, gpu1temp, 95, color_frompercent(gpu1temp/95))
    write(settings.temp.value2, settings.temp.value - settings.line.height, gpu1temp .. "°C", 12, main_text_color)
    write(settings.temp.label2, settings.temp.label - settings.line.height, "GPU1", 12, main_text_color, "r")

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

    for thread = 1, cpu_cores do
        y = settings.cpu.y_util + (thread - 1) * settings.line.interval
        rectangle_rightleft(settings.line.utilxr, y, settings.line.width_4, settings.line.thickness, cpu_percent(thread), 100, color_frompercent(tonumber(cpu_percent(thread))))
        write(settings.text.centerxr, y - settings.line.height, cpu_percent(thread) .. "%", 12, main_text_color)
        write(settings.text.utilxr, y - settings.line.height, cpu_freq(thread) .. " MHz", 12, main_text_color, "r")
    end

    for thread = cpu_cores + 1, cpu_threads do
        y = settings.cpu.y_util + (thread - 7) * settings.line.interval
        rectangle_rightleft(settings.line.startx, y, settings.line.width_4, settings.line.thickness, cpu_percent(thread), 100, color_frompercent(tonumber(cpu_percent(thread))))
        write(settings.text.utilxl, y - settings.line.height, cpu_percent(thread) .. "%", 12, main_text_color)
        write(settings.text.startx, y - settings.line.height, cpu_freq(thread) .. " MHz", 12, main_text_color, "r")
    end
end

function draw_gpu1()
    write_bold(settings.line.endx, settings.gpu1.separator + settings.line.height / 2, "GPU1: " .. gpu_name(1), 12, main_text_color)
    line(settings.line.startx, settings.gpu1.separator, settings.line.endx + 180, settings.gpu1.separator, settings.line.thickness, main_text_color, 1)

    local gpufan        = tonumber(gpu_fanspeed(1))
    local gpupowerdraw  = tonumber(gpu_power_draw(1)) or 0
    local gpupowerlimit = tonumber(gpu_power_limit(1)) or 75
    local gpuutil       = tonumber(gpu_utilization(1))
    local gpumemused    = tonumber(gpu_mem_used(1))
    local gpumemtotal   = tonumber(gpu_mem_total(1))
    local gpumemutil    = math.floor(gpumemused/gpumemtotal*100)
    local gpuencode     = tonumber(gpu_encode(1))
    local gpudecode     = tonumber(gpu_decode(1))

    rectangle_rightleft(settings.line.centerxl, settings.gpu1.y_fan, settings.line.width_2, settings.line.thickness, gpufan, 100, color_frompercent(gpufan))
    write(settings.text.endx, settings.gpu1.y_fan - settings.line.height, gpufan .. "%", 12, main_text_color)
    write(settings.text.centerxl, settings.gpu1.y_fan - settings.line.height, "Fan speed", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.centerxl, settings.gpu1.y_power, settings.line.width_2, settings.line.thickness, gpupowerdraw, gpupowerlimit, color_frompercent(gpupowerdraw/gpupowerlimit))
    write(settings.text.endx, settings.gpu1.y_power - settings.line.height, gpupowerdraw .. "W", 12, main_text_color)
    write(settings.text.centerxl, settings.gpu1.y_power - settings.line.height, "Power usage", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.centerxl, settings.gpu1.y_ram, settings.line.width_2, settings.line.thickness, gpumemutil, 100, color_frompercent(gpumemutil))
    write(settings.text.endx, settings.gpu1.y_ram - settings.line.height, gpumemutil .. " %", 12, main_text_color)
    write(settings.text.centerxl, settings.gpu1.y_ram - settings.line.height, "RAM " .. gpumemused .. " / " .. gpumemtotal .. " MiB", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.gpu1.y_util, settings.line.width_2, settings.line.thickness, gpuutil, 100, color_frompercent(gpuutil))
    write(settings.text.centerxr, settings.gpu1.y_util - settings.line.height, gpuutil .. "%", 12, main_text_color)
    write(settings.text.startx, settings.gpu1.y_util - settings.line.height, "Core", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.gpu1.y_decode, settings.line.width_2, settings.line.thickness, gpudecode, 100, color_frompercent(gpudecode))
    write(settings.text.centerxr, settings.gpu1.y_decode - settings.line.height, gpudecode .. "%", 12, main_text_color)
    write(settings.text.startx, settings.gpu1.y_decode - settings.line.height, "Decoder", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.gpu1.y_encode, settings.line.width_2, settings.line.thickness, gpuencode, 100, color_frompercent(gpuencode))
    write(settings.text.centerxr, settings.gpu1.y_encode - settings.line.height, gpuencode .. "%", 12, main_text_color)
    write(settings.text.startx, settings.gpu1.y_encode - settings.line.height, "Encoder", 12, main_text_color, "r")
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

function draw_data()
    write_bold(settings.line.endx, settings.data.separator + settings.line.height / 2, "STORAGE & NETWORK", 12, main_text_color)
    line(settings.line.startx, settings.data.separator, settings.line.endx + 128, settings.data.separator, settings.line.thickness, main_text_color, 1)

    -- Network info
    local vals = {
        "Total down: " .. download_total(),
        "Total up:   " .. upload_total(),
    }
    if use_public_ip then
        table.insert(vals, "Public IP: " .. public_ip)
        table.insert(vals, "VPN IP:    " .. vpn_ip)
    end
    table.insert(vals, "Local IP:  " .. local_ip())
    write_line_by_line(settings.text.endx, settings.data.y_info_net, settings.line.info_height, vals, main_text_color, 12, false)

    -- Local volumes
    local root          = string.format("/: %s / %s", fs_used("/"), fs_size("/"))
    local rootperc      = tonumber(fs_used_perc("/"))

    rectangle_rightleft(settings.line.startx, settings.data.y_ssd_util, settings.line.width_5, settings.line.thickness, rootperc, 100, color_frompercent(rootperc))
    write(settings.text.midxl, settings.data.y_ssd_util - settings.line.height, rootperc .. "%", 12, main_text_color)
    write(settings.text.startx, settings.data.y_ssd_util - settings.line.height, root, 12, main_text_color, "r")

    -- Network volumes
    local jodibooks     = string.format("/media/jodibooks-share: %s / %s", fs_used("/media/jodibooks-share"), fs_size("/media/jodibooks-share"))
    local joediapna     = string.format("/media/joediapna-share: %s / %s", fs_used("/media/joediapna-share"), fs_size("/media/joediapna-share"))
    local user          = string.format("/media/joep: %s / %s", fs_used("/media/joep"), fs_size("/media/joep"))
    local jodibooksperc = tonumber(fs_used_perc("/media/jodibooks-share"))
    local joediapnaperc = tonumber(fs_used_perc("/media/joediapna-share"))
    local userperc      = tonumber(fs_used_perc("/media/joep"))

    rectangle_rightleft(settings.line.startx, settings.data.y_sh1, settings.line.width_5, settings.line.thickness, jodibooksperc, 100, color_frompercent(jodibooksperc))
    write(settings.text.midxl, settings.data.y_sh1 - settings.line.height, jodibooksperc .. "%", 12, main_text_color)
    write(settings.text.startx, settings.data.y_sh1 - settings.line.height, jodibooks, 12, main_text_color, "r")
    rectangle_rightleft(settings.line.startx, settings.data.y_sh2, settings.line.width_5, settings.line.thickness, joediapnaperc, 100, color_frompercent(joediapnaperc))
    write(settings.text.midxl, settings.data.y_sh2 - settings.line.height, joediapnaperc .. "%", 12, main_text_color)
    write(settings.text.startx, settings.data.y_sh2 - settings.line.height, joediapna, 12, main_text_color, "r")
    rectangle_rightleft(settings.line.startx, settings.data.y_sh3, settings.line.width_5, settings.line.thickness, userperc, 100, color_frompercent(userperc))
    write(settings.text.startx, settings.data.y_sh3 - settings.line.height, user, 12, main_text_color, "r")
    write(settings.text.midxl, settings.data.y_sh3 - settings.line.height, userperc .. "%", 12, main_text_color)

    -- Network speeds
    local downspeed = download_speed()
    local upspeed = upload_speed()
    local downraw = tonumber(download_speed_raw())
    local upraw = tonumber(upload_speed_raw())

    rectangle_rightleft(settings.line.centerxl, settings.data.y_speed_down, settings.line.width_2, settings.line.thickness, downraw, net_rate_maximum, color_frompercent(downraw/net_rate_maximum))
    write(settings.text.endx, settings.data.y_speed_down - settings.line.height, downspeed, 12, main_text_color)
    write(settings.text.centerxl, settings.data.y_speed_down - settings.line.height, "Down", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.centerxl, settings.data.y_speed_up, settings.line.width_2, settings.line.thickness, upraw, net_rate_maximum, color_frompercent(upraw/net_rate_maximum))
    write(settings.text.endx, settings.data.y_speed_up - settings.line.height, upspeed, 12, main_text_color)
    write(settings.text.centerxl, settings.data.y_speed_up - settings.line.height, "Up", 12, main_text_color, "r")

    -- Drive speeds
    local readspeed = diskio_read("/dev/nvme0n1")
    local writespeed = diskio_write("/dev/nvme0n1")
    local readraw = tonumber(break_after_first_word(readspeed, " "))
    local writeraw = tonumber(break_after_first_word(writespeed, " "))

    rectangle_rightleft(settings.line.startx, settings.data.y_speed_read, settings.line.width_2, settings.line.thickness, readraw, nvme_throughput, color_frompercent(readraw/nvme_throughput))
    write(settings.text.centerxr, settings.data.y_speed_read - settings.line.height, readspeed, 12, main_text_color)
    write(settings.text.startx, settings.data.y_speed_read - settings.line.height, "Read", 12, main_text_color, "r")

    rectangle_rightleft(settings.line.startx, settings.data.y_speed_write, settings.line.width_2, settings.line.thickness, writeraw, nvme_throughput, color_frompercent(writeraw/nvme_throughput))
    write(settings.text.centerxr, settings.data.y_speed_write - settings.line.height, writespeed, 12, main_text_color)
    write(settings.text.startx, settings.data.y_speed_write - settings.line.height, "Write", 12, main_text_color, "r")
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
