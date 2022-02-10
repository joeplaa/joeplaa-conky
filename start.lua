----------------------------------
-- Author:      Zineddine SAIBI
-- Software:    Pomaria-Side
-- Type:        Conky Theme
-- License:     GPL-3.0
-- repository:  https://www.github.com/SZinedine/pomaria-side
----------------------------------

require 'abstract'

settings = {
    base = {},
    line = {},
    text = {},
    clock= {},
    info = {},
    cpu  = {},
    mem  = {},
    disk = {},
    net  = {},
}

settings.base.margin            = 16
settings.base.x                 = 600 -- this should be the same as conky.config.minimum_width
settings.base.y                 = 40

settings.line.thickness         = 2
settings.line.height            = 10
settings.line.startx            = settings.base.x - settings.base.margin / 2    -- right
settings.line.centerx           = settings.base.x / 2                           -- center
settings.line.endx              = settings.base.margin                          -- left
settings.line.width             = settings.base.x - 2 * settings.base.margin
settings.line.width1            = settings.base.x / 2 - settings.base.margin
settings.line.width2            = settings.line.width1 * 2 + settings.base.margin
settings.line.interval          = 40
settings.line.section_interval  = settings.line.interval * 1.25

settings.text.startx            = settings.base.x - settings.base.margin        -- right
settings.text.centerxl          = settings.base.x / 2 - settings.base.margin / 2-- center left column
settings.text.centerxr          = settings.base.x / 2 + settings.base.margin    -- center right column
settings.text.endx              = settings.base.margin * 1.5                    -- left

settings.clock.time_x           = settings.base.x
settings.clock.time_y           = settings.base.y + settings.line.interval * 2
settings.clock.date_x           = settings.clock.time_x
settings.clock.date_y           = settings.clock.time_y + 30

settings.info.separator         = settings.clock.date_y + settings.line.interval
settings.info.y                 = settings.info.separator + settings.line.interval
settings.info.y_temp            = settings.info.separator + settings.line.section_interval
settings.info.y_fan1            = settings.info.y_temp + settings.line.interval
settings.info.y_fan2            = settings.info.y_fan1 + settings.line.interval

settings.cpu.separator          = settings.info.y_fan2 + settings.line.interval
settings.cpu.y                  = settings.cpu.separator
settings.cpu.y_temp             = settings.cpu.y + settings.line.section_interval
settings.cpu.y_fan              = settings.cpu.y_temp + settings.line.interval
settings.cpu.y_total            = settings.cpu.y_temp + (cpu_cores) * settings.line.interval
settings.cpu.y_info             = settings.cpu.y_fan + settings.line.interval
settings.cpu.x_values           = settings.base.x - settings.line.width1 - 30

settings.mem.separator          = settings.cpu.y_total + settings.line.interval
settings.mem.y                  = settings.mem.separator
settings.mem.y_ram              = settings.mem.separator + settings.line.section_interval
settings.mem.y_swap             = settings.mem.y_ram + settings.line.interval
settings.mem.y_info             = settings.mem.y_swap + settings.line.interval

settings.disk.separator         = settings.mem.y_info + settings.line.interval * 3.5
settings.disk.y                 = settings.disk.separator + settings.line.interval
settings.disk.y1                = settings.disk.separator + settings.line.section_interval

settings.net.separator          = settings.disk.y1 + settings.line.interval * 1.5
settings.net.y                  = settings.net.separator + settings.line.interval
settings.net.y1                 = settings.net.separator + settings.line.section_interval
settings.net.y2                 = settings.net.y1 + settings.line.interval
settings.net.y3                 = settings.net.y2 + settings.line.interval

-- replace the content of the following function to create your own conky theme
function start()
    draw_clock()
    draw_info()
    draw_cpu()
    draw_memory()
    draw_disks()
    draw_net()
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
    write_line_by_line(settings.text.endx, settings.info.y, 20, vals, main_text_color, 12, false)

    local systemp   = sys_temperature()
    local sysfan1   = sys_fanspeed1()
    local sysfan2   = sys_fanspeed2()

    rectangle_rightleft(settings.line.startx, settings.info.y_temp, settings.line.width1, settings.line.thickness, systemp, 70, color_frompercent(tonumber(systemp/70)))
    rectangle_rightleft(settings.line.startx, settings.info.y_fan1, settings.line.width1, settings.line.thickness, sysfan1, 1150, color_frompercent(tonumber(sysfan1/1150)))
    rectangle_rightleft(settings.line.startx, settings.info.y_fan2, settings.line.width1, settings.line.thickness, sysfan2, 1250, color_frompercent(tonumber(sysfan2/1250)))

    -- values
    write(settings.text.centerxr, settings.info.y_temp - settings.line.height, systemp .. "°C", 12, main_text_color)
    write(settings.text.centerxr, settings.info.y_fan1 - settings.line.height, sysfan1 .. " RPM", 12, main_text_color)
    write(settings.text.centerxr, settings.info.y_fan2 - settings.line.height, sysfan2 .. " RPM", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.info.y_temp - settings.line.height, "System temperature", 12, main_text_color, "r")
    write(settings.text.startx, settings.info.y_fan1 - settings.line.height, "System fan 1 speed", 12, main_text_color, "r")
    write(settings.text.startx, settings.info.y_fan2 - settings.line.height, "System fan 2 speed", 12, main_text_color, "r")
end

function draw_cpu()
    write_bold(settings.line.endx, settings.cpu.separator + settings.line.height / 2, "CPU", 12, main_text_color)
    line(settings.line.startx, settings.cpu.separator, settings.line.endx + 32, settings.cpu.separator, settings.line.thickness, main_text_color, 1)

    -- cpu info
    local vals = {
        "Load avg: " .. load_avg(),
    }
    write_line_by_line(settings.text.endx, settings.cpu.y_info, 20, vals, main_text_color, 12, false)
    -- processes list by cpu consumption
    write_list_proccesses_cpu(settings.text.endx, settings.cpu.y_fan + 2 * settings.line.interval, 20, 10, 12, main_text_color)

    local cputemp       = cpu_temperature()
    local cpufanspeed   = cpu_fanspeed()
    local cpu           = cpu_percent()

    rectangle_rightleft(settings.line.centerx, settings.cpu.y_temp, settings.line.width1, settings.line.thickness, cputemp, 80, color_frompercent(tonumber(cputemp/80)))
    rectangle_rightleft(settings.line.centerx, settings.cpu.y_fan, settings.line.width1, settings.line.thickness, cpufanspeed, 1550, color_frompercent(tonumber(cpufanspeed/1550)))
    for i = 1, cpu_cores do
        y = settings.cpu.y_temp + (i - 1) * settings.line.interval
        rectangle_rightleft(settings.line.startx, y, settings.line.width1, settings.line.thickness, cpu_percent(i), 100, color_frompercent(tonumber(cpu_percent(i))))
    end
    rectangle_rightleft(settings.line.startx, settings.cpu.y_total, settings.line.width1, settings.line.thickness, cpu, 100, color_frompercent(tonumber(cpu)))

    -- values
    write(settings.text.endx, settings.cpu.y_temp - settings.line.height, cputemp .. "°C", 12, main_text_color)
    write(settings.text.endx, settings.cpu.y_fan - settings.line.height, cpufanspeed .. " RPM", 12, main_text_color)
    for i = 1, cpu_cores do
        y = settings.cpu.y_temp + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.centerxr, y, cpu_percent(i) .. "%", 12, main_text_color)
    end
    write(settings.text.centerxr, settings.cpu.y_total - settings.line.height, cpu .. "%", 12, main_text_color)

    -- titles
    write(settings.text.centerxl, settings.cpu.y_temp - settings.line.height, "CPU temperature", 12, main_text_color, "r")
    write(settings.text.centerxl, settings.cpu.y_fan - settings.line.height, "CPU fan speed", 12, main_text_color, "r")
    for i = 1, cpu_cores do
        y = settings.cpu.y_temp + (i - 1) * settings.line.interval - settings.line.height
        write(settings.text.startx, y, "CPU " .. i .. ": " .. cpu_freq(i) .. " MHz", 12, main_text_color, "r")
    end
    write(settings.text.startx, settings.cpu.y_total - settings.line.height, "total CPU", 12, main_text_color, "r")
end

function draw_memory()
    write_bold(settings.line.endx, settings.mem.separator + settings.line.height / 2, "MEMORY", 12, main_text_color)
    line(settings.line.startx, settings.mem.separator, settings.line.endx + 56, settings.mem.separator, settings.line.thickness, main_text_color, 1)

    -- processes list by mem consumption
    write_list_proccesses_mem(settings.text.endx, settings.mem.y_ram, 20, 10, 12, main_text_color)

    local memperc  = memory_percent()
    local swapperc = swap_percent()
    local mem      = string.format("RAM: %s / %s", memory(), memory_max())
    local swp      = string.format("Swap: %s / %s", swap(), swap_max())

    rectangle_rightleft(settings.line.startx, settings.mem.y_ram, settings.line.width1, settings.line.thickness, memperc, 100, color_frompercent(tonumber(memperc)))
    rectangle_rightleft(settings.line.startx, settings.mem.y_swap, settings.line.width1, settings.line.thickness, swapperc, 100, color_frompercent(tonumber(swapperc)))

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
    write_line_by_line(settings.text.centerxr, settings.mem.y_info, 20, vals, main_text_color, 12, false)
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
    write_line_by_line(settings.text.endx, settings.disk.y, 20, vals, main_text_color, 12, false)

    --local ssdtemp       = ssd_temperature()
    local root          = string.format("SSD: %s / %s", fs_used("/"), fs_size("/"))
    local rootperc      = fs_used_perc("/")

    rectangle_rightleft(settings.line.startx, settings.disk.y1, settings.line.width1, settings.line.thickness, rootperc, 100, color_frompercent(tonumber(rootperc)))
    --rectangle_rightleft(settings.line.startx, settings.disk.y2, settings.line.width1, settings.line.thickness, win10perc, 100, color_frompercent(tonumber(win10perc)))

    -- values
    write(settings.text.centerxr, settings.disk.y1 - settings.line.height, rootperc .. "%", 12, main_text_color)
    --write(settings.text.centerxr, settings.disk.y2 - settings.line.height, win10perc .. "%", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.disk.y1 - settings.line.height, root, 12, main_text_color, "r")
    --write(settings.text.startx, settings.disk.y2 - settings.line.height, win10, 12, main_text_color, "r")
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
    write_line_by_line(settings.text.endx, settings.net.y, 20, vals, main_text_color, 12, false)

    local jodibooks     = string.format("jodibooks-share: %s / %s", fs_used("/media/jodibooks-share"), fs_size("/media/jodibooks-share"))
    local joediapna     = string.format("joediapna-share: %s / %s", fs_used("/media/joediapna-share"), fs_size("/media/joediapna-share"))
    local user          = string.format("user-share: %s / %s", fs_used("/media/joep"), fs_size("/media/joep"))
    local jodibooksperc = fs_used_perc("/media/jodibooks-share")
    local joediapnaperc = fs_used_perc("/media/joediapna-share")
    local userperc      = fs_used_perc("/media/joep")

    rectangle_rightleft(settings.line.startx, settings.net.y1, settings.line.width1, settings.line.thickness, jodibooksperc, 100, color_frompercent(tonumber(jodibooksperc)))
    rectangle_rightleft(settings.line.startx, settings.net.y2, settings.line.width1, settings.line.thickness, joediapnaperc, 100, color_frompercent(tonumber(joediapnaperc)))
    rectangle_rightleft(settings.line.startx, settings.net.y3, settings.line.width1, settings.line.thickness, userperc, 100, color_frompercent(tonumber(userperc)))

    -- values
    write(settings.text.centerxr, settings.net.y1 - settings.line.height, jodibooksperc .. "%", 12, main_text_color)
    write(settings.text.centerxr, settings.net.y2 - settings.line.height, joediapnaperc .. "%", 12, main_text_color)
    write(settings.text.centerxr, settings.net.y3 - settings.line.height, userperc .. "%", 12, main_text_color)

    -- titles
    write(settings.text.startx, settings.net.y1 - settings.line.height, jodibooks, 12, main_text_color, "r")
    write(settings.text.startx, settings.net.y2 - settings.line.height, joediapna, 12, main_text_color, "r")
    write(settings.text.startx, settings.net.y3 - settings.line.height, user, 12, main_text_color, "r")
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
