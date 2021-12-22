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
    clock= {},
    info = {},
    cpu  = {},
    mem  = {},
    disk = {},
    net  = {},
}

settings.base.x                 = 600
settings.base.y                 = 40

settings.line.thickness         = 2
settings.line.height            = 10
settings.line.start             = 30
settings.line.width1            = settings.base.x / 2 - settings.line.start - 10
settings.line.width2            = settings.line.width1 * 2 + settings.line.start + 10
settings.line.interval          = 40
settings.line.section_interval  = settings.line.interval * 1.5

settings.clock.time_x           = settings.base.x - settings.line.width1
settings.clock.time_y           = settings.base.y + settings.line.interval * 2
settings.clock.date_x           = settings.clock.time_x + 30
settings.clock.date_y           = settings.clock.time_y + 30

settings.info.x                 = settings.base.x
settings.info.y                 = settings.base.y
settings.info.y_temp            = settings.clock.date_y + settings.line.section_interval
settings.info.y_fan1            = settings.info.y_temp + settings.line.interval
settings.info.y_fan2            = settings.info.y_fan1 + settings.line.interval
settings.info.width             = settings.line.width1
settings.info.width_temp        = settings.line.width2
settings.info.width_fan         = settings.info.width_temp

settings.cpu.x                  = settings.base.x
settings.cpu.y                  = settings.info.y_fan2
settings.cpu.y_temp             = settings.cpu.y + settings.line.section_interval
settings.cpu.y_fan              = settings.cpu.y_temp + settings.line.interval
settings.cpu.y_total            = settings.cpu.y_fan + (cpu_cores + 1) * settings.line.interval
settings.cpu.y_info             = settings.cpu.y_fan + settings.line.interval
settings.cpu.width              = settings.line.width1
settings.cpu.width_temp         = settings.line.width2
settings.cpu.width_fan          = settings.cpu.width_temp
settings.cpu.x_values           = settings.base.x - settings.cpu.width - 30

settings.disk.x                 = settings.base.x
settings.disk.x_text            = settings.base.x - settings.line.width1
settings.disk.y1                = settings.cpu.y_total + settings.line.section_interval
settings.disk.y2                = settings.disk.y1 + settings.line.interval
settings.disk.y3                = settings.disk.y2 + settings.line.interval
settings.disk.y4                = settings.disk.y3 + settings.line.interval
settings.disk.y5                = settings.disk.y4 + settings.line.interval
settings.disk.y                 = settings.disk.y5 + settings.line.interval

settings.mem.x                  = settings.base.x / 2
settings.mem.y                  = settings.disk.y3
settings.mem.y_ram              = settings.disk.y1
settings.mem.y_swap             = settings.mem.y_ram + settings.line.interval

settings.net.x                  = settings.base.x - settings.line.width1
settings.net.y                  = settings.disk.y + settings.line.section_interval + settings.line.interval

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
    write(settings.clock.time_x, settings.clock.time_y, time_hrmin(), 85, main_text_color)
    write(settings.clock.date_x, settings.clock.date_y, string.format("%s, %s %s, %s", time_day_short(), time_month_short(), time_day_number(), time_year()), 20, main_text_color)
end

function draw_info()
    local vals = {
        "Hostname:  " .. hostname(),
        "Uptime:    " .. uptime(),
        "OS:        " .. os(),
        "Kernel:    " .. kernel(),
        string.format("Desktop:   %s/%s", desktop(), desktops()),
    }
    if use_public_ip then
        table.insert(vals, "Public IP: " .. public_ip)
    end
    table.insert(vals, "Local IP:  " .. local_ip())
    write_line_by_line(settings.info.x-settings.line.width2, settings.info.y, 20, vals, main_text_color, 12, false)

    local systemp   = sys_temperature()
    local sysfan1   = sys_fanspeed1()
    local sysfan2   = sys_fanspeed2()

    rectangle_rightleft(settings.info.x, settings.info.y_temp, settings.info.width_temp, settings.line.thickness, systemp, 70, color_frompercent(tonumber(systemp/70)))
    rectangle_rightleft(settings.info.x, settings.info.y_fan1, settings.info.width_temp, settings.line.thickness, sysfan1, 1150, color_frompercent(tonumber(sysfan1/1150)))
    rectangle_rightleft(settings.info.x, settings.info.y_fan2, settings.info.width_temp, settings.line.thickness, sysfan2, 1250, color_frompercent(tonumber(sysfan2/1250)))

    write(settings.info.x-settings.info.width_temp-settings.line.start, settings.info.y_temp, systemp .. "°C", 12, main_text_color)
    write(settings.info.x-settings.info.width_fan-settings.line.start, settings.info.y_fan1, sysfan1 .. " RPM", 12, main_text_color)
    write(settings.info.x-settings.info.width_fan-settings.line.start, settings.info.y_fan2, sysfan2 .. " RPM", 12, main_text_color)

    write(settings.info.x-140, settings.info.y_temp-settings.line.height, "System temperature", 12, main_text_color)
    write(settings.info.x-140, settings.info.y_fan1-settings.line.height, "System fan 1 speed", 12, main_text_color)
    write(settings.info.x-140, settings.info.y_fan2-settings.line.height, "System fan 2 speed", 12, main_text_color)
end

function draw_cpu()
    local cputemp       = cpu_temperature()
    local cpufanspeed   = cpu_fanspeed()
    local cpu           = cpu_percent()

    rectangle_rightleft(settings.cpu.x, settings.cpu.y_temp, settings.cpu.width_temp, settings.line.thickness, cputemp, 80, color_frompercent(tonumber(cputemp/80)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y_fan, settings.cpu.width_temp, settings.line.thickness, cpufanspeed, 1550, color_frompercent(tonumber(cpufanspeed/1550)))
    for i = 1, cpu_cores do
        y = settings.cpu.y_fan + i * settings.line.interval
        rectangle_rightleft(settings.cpu.x, y, settings.cpu.width, settings.line.thickness, cpu_percent(i), 100, color_frompercent(tonumber(cpu_percent(i))))
    end
    rectangle_rightleft(settings.cpu.x, settings.cpu.y_total, settings.cpu.width_temp, settings.line.thickness, cpu, 100, color_frompercent(tonumber(cpu)))

    -- cpu values
    write(settings.cpu.x-settings.cpu.width_temp-settings.line.start, settings.cpu.y_temp, cputemp .. "°C", 12, main_text_color)
    write(settings.cpu.x-settings.cpu.width_fan-settings.line.start, settings.cpu.y_fan, cpufanspeed .. " RPM", 12, main_text_color)
    for i = 1, cpu_cores do
        y = settings.cpu.y_fan + i * settings.line.interval
        write(settings.cpu.x_values, y, cpu_percent(i) .. "%", 12, main_text_color)
    end
    write(settings.cpu.x-settings.cpu.width_temp-settings.line.start, settings.cpu.y_total, cpu .. "%", 12, main_text_color)

    -- cpu titles
    write(settings.cpu.x-120, settings.cpu.y_temp-settings.line.height, "CPU temperature", 12, main_text_color)
    write(settings.cpu.x-105, settings.cpu.y_fan-settings.line.height, "CPU fan speed", 12, main_text_color)
    for i = 1, cpu_cores do
        y = settings.cpu.y_fan + i * settings.line.interval - settings.line.height
        write(settings.cpu.x-120, y, "CPU " .. i .. ": " .. cpu_freq(i) .. " MHz", 12, main_text_color)
    end
    write(settings.cpu.x-75, settings.cpu.y_total-settings.line.height, "total CPU", 12, main_text_color)

    -- cpu info
    local vals = {
        "Load avg: " .. load_avg(),
        "Top processes:",
    }
    write_line_by_line(settings.cpu.x-settings.line.width2, settings.cpu.y_info, 20, vals, main_text_color, 12, false)

    -- processes list by cpu consumption
    write_list_proccesses_cpu(settings.cpu.x-settings.line.width2+16, settings.cpu.y_fan + 2 * settings.line.interval, 20, 10, 12, main_text_color)
end

function draw_memory()
    local memperc  = memory_percent()
    local swapperc = swap_percent()
    local mem      = string.format("RAM: %s / %s", memory(), memory_max())
    local swp      = string.format("Swap: %s / %s", swap(), swap_max())

    rectangle_rightleft(settings.mem.x, settings.mem.y_ram, settings.line.width1, settings.line.thickness, memperc, 100, color_frompercent(tonumber(memperc)))
    rectangle_rightleft(settings.mem.x, settings.mem.y_swap, settings.line.width1, settings.line.thickness, swapperc, 100, color_frompercent(tonumber(swapperc)))

    write(settings.mem.x-180, settings.mem.y_ram-settings.line.height, mem, 12, main_text_color)
    write(settings.mem.x-180, settings.mem.y_swap-settings.line.height, swp, 12, main_text_color)

    write(settings.mem.x-settings.line.width1-settings.line.start, settings.mem.y_ram, memperc .. "%", 12, main_text_color)
    write(settings.mem.x-settings.line.width1-settings.line.start, settings.mem.y_swap, swapperc .. "%", 12, main_text_color)

    -- mem info
    local vals = {
        "MiB mem:",
        "  Total:    " .. memory_max(),
        "  Buffered: " .. memory_buffers(),
        "  Cached:   " .. memory_cached(),
        "  Used:     " .. memory(),
    }
    table.insert(vals, "Top processes:")
    write_line_by_line(settings.mem.x - settings.line.width1, settings.mem.y, 20, vals, main_text_color, 12, false)

    -- processes list by mem consumption
    write_list_proccesses_mem(settings.mem.x - settings.line.width1 + 16, settings.mem.y + 3 * settings.line.interval, 20, 10, 12, main_text_color)
end

function draw_disks()
    --local ssdtemp       = ssd_temperature()
    local root          = string.format("SSD: %s / %s", fs_used("/"), fs_size("/"))
    local win10         = string.format("VM WIN10: %s / %s", vm_used("win10.qcow2"), vm_size("win10.qcow2"))
    local jodibooks     = string.format("jodibooks-share: %s / %s", fs_used("/media/jodibooks-share"), fs_size("/media/jodibooks-share"))
    local joediapna     = string.format("joediapna-share: %s / %s", fs_used("/media/joediapna-share"), fs_size("/media/joediapna-share"))
    local user          = string.format("user-share: %s / %s", fs_used("/media/joep"), fs_size("/media/joep"))
    local rootperc      = fs_used_perc("/")
    local win10perc     = vm_used_perc("win10.qcow2")
    local jodibooksperc = fs_used_perc("/media/jodibooks-share")
    local joediapnaperc = fs_used_perc("/media/joediapna-share")
    local userperc      = fs_used_perc("/media/joep")

    --rectangle_rightleft(settings.disk.x, settings.disk.y_temp, settings.disk.width_temp, settings.line.thickness, ssdtemp, 70, color_frompercent(tonumber(ssdtemp)/70))
    rectangle_rightleft(settings.disk.x, settings.disk.y1, settings.line.width1, settings.line.thickness, rootperc, 100, color_frompercent(tonumber(rootperc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y2, settings.line.width1, settings.line.thickness, win10perc, 100, color_frompercent(tonumber(win10perc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y3, settings.line.width1, settings.line.thickness, jodibooksperc, 100, color_frompercent(tonumber(jodibooksperc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y4, settings.line.width1, settings.line.thickness, joediapnaperc, 100, color_frompercent(tonumber(joediapnaperc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y5, settings.line.width1, settings.line.thickness, userperc, 100, color_frompercent(tonumber(userperc)))

    --write(settings.disk.x, settings.disk.y1, ssdtemp, 12, main_text_color)
    write(settings.disk.x_text, settings.disk.y1-settings.line.height, root, 12, main_text_color)
    write(settings.disk.x_text, settings.disk.y2-settings.line.height, win10, 12, main_text_color)
    write(settings.disk.x_text, settings.disk.y3-settings.line.height, jodibooks, 12, main_text_color)
    write(settings.disk.x_text, settings.disk.y4-settings.line.height, joediapna, 12, main_text_color)
    write(settings.disk.x_text, settings.disk.y5-settings.line.height, user, 12, main_text_color)
    write(settings.disk.x_text-settings.line.start, settings.disk.y1, rootperc .. "%", 12, main_text_color)
    write(settings.disk.x_text-settings.line.start, settings.disk.y2, win10perc .. "%", 12, main_text_color)
    write(settings.disk.x_text-settings.line.start, settings.disk.y3, jodibooksperc .. "%", 12, main_text_color)
    write(settings.disk.x_text-settings.line.start, settings.disk.y4, joediapnaperc .. "%", 12, main_text_color)
    write(settings.disk.x_text-settings.line.start, settings.disk.y5, userperc .. "%", 12, main_text_color)

    local vals = {
        "Disk I/O:  " .. diskio("/dev/sda"),
        "  Read:    " .. diskio_read("/dev/sda"),
        "  Write:   " .. diskio_write("/dev/sda"),
    }
    write_line_by_line(settings.disk.x_text, settings.disk.y, 20, vals, main_text_color, 12, false)
end

function draw_net()
    local vals = {
        "Total download: " .. download_total(),
        "Total upload:   " .. upload_total(),
        "Net speed:",
        "  Download:     " .. download_speed(),
        "  Upload:       " .. upload_speed(),
    }
    write_line_by_line(settings.net.x, settings.net.y, 20, vals, main_text_color, 12, false)
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