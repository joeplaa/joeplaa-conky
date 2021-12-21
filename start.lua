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

settings.line.thickness         = 1
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
settings.info.y                 = settings.base.y + settings.line.interval
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
settings.cpu.y1                 = settings.cpu.y_fan + settings.line.interval
settings.cpu.y2                 = settings.cpu.y1 + settings.line.interval
settings.cpu.y3                 = settings.cpu.y2 + settings.line.interval
settings.cpu.y4                 = settings.cpu.y3 + settings.line.interval
settings.cpu.y5                 = settings.cpu.y4 + settings.line.interval
settings.cpu.y6                 = settings.cpu.y5 + settings.line.interval
settings.cpu.y7                 = settings.cpu.y6 + settings.line.interval
settings.cpu.y8                 = settings.cpu.y7 + settings.line.interval
settings.cpu.y_total            = settings.cpu.y8 + settings.line.interval
settings.cpu.width              = settings.line.width1
settings.cpu.width_temp         = settings.line.width2
settings.cpu.width_fan          = settings.cpu.width_temp
settings.cpu.x_values           = settings.base.x - settings.cpu.width - 30

settings.disk.x                 = settings.base.x
settings.disk.y1                = settings.cpu.y_total + settings.line.section_interval
settings.disk.y2                = settings.disk.y1 + settings.line.interval
settings.disk.y3                = settings.disk.y2 + settings.line.interval
settings.disk.y4                = settings.disk.y3 + settings.line.interval
settings.disk.y                 = settings.disk.y4 + settings.line.interval

settings.mem.x                  = settings.base.x / 2
settings.mem.y                  = settings.disk.y3
settings.mem.y_ram              = settings.disk.y1
settings.mem.y_swap             = settings.mem.y_ram + settings.line.interval
settings.mem.width              = settings.line.width1

settings.net.down_x             = settings.base.x
settings.net.down_y             = settings.disk.y + settings.line.section_interval + settings.line.interval
settings.net.up_y               = settings.net.down_y + settings.line.interval
settings.net.width              = settings.line.width1

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

    local vals = {
        "Uptime:    " .. uptime(),
        string.format("Desktop:   %s/%s", desktop(), desktops()),
    }
    if use_public_ip then
        table.insert(vals, "Public IP: " .. public_ip)
    end
    table.insert(vals, "Local IP:  " .. local_ip())
    write_line_by_line(settings.info.x-settings.line.width2, settings.info.y, 20, vals, main_text_color, 12, false)
end

function draw_cpu()
    local cputemp       = cpu_temperature()
    local cpufanspeed   = cpu_fanspeed()
    local cpu           = cpu_percent()
    local cpu1          = cpu_percent(1)
    local cpu2          = cpu_percent(2)
    local cpu3          = cpu_percent(3)
    local cpu4          = cpu_percent(4)
    local cpu5          = cpu_percent(5)
    local cpu6          = cpu_percent(6)
    local cpu7          = cpu_percent(7)
    local cpu8          = cpu_percent(8)

    rectangle_rightleft(settings.cpu.x, settings.cpu.y_temp, settings.cpu.width_temp, settings.line.thickness, cputemp, 80, color_frompercent(tonumber(cputemp/80)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y_fan, settings.cpu.width_temp, settings.line.thickness, cpufanspeed, 1550, color_frompercent(tonumber(cpufanspeed/1550)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y1, settings.cpu.width, settings.line.thickness, cpu1, 100, color_frompercent(tonumber(cpu1)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y2, settings.cpu.width, settings.line.thickness, cpu2, 100, color_frompercent(tonumber(cpu2)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y3, settings.cpu.width, settings.line.thickness, cpu3, 100, color_frompercent(tonumber(cpu3)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y4, settings.cpu.width, settings.line.thickness, cpu4, 100, color_frompercent(tonumber(cpu4)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y5, settings.cpu.width, settings.line.thickness, cpu5, 100, color_frompercent(tonumber(cpu5)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y6, settings.cpu.width, settings.line.thickness, cpu6, 100, color_frompercent(tonumber(cpu6)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y7, settings.cpu.width, settings.line.thickness, cpu7, 100, color_frompercent(tonumber(cpu7)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y8, settings.cpu.width, settings.line.thickness, cpu8, 100, color_frompercent(tonumber(cpu8)))
    rectangle_rightleft(settings.cpu.x, settings.cpu.y_total, settings.cpu.width_temp, settings.line.thickness, cpu, 100, color_frompercent(tonumber(cpu)))

    -- cpu values
    write(settings.cpu.x-settings.cpu.width_temp-settings.line.start, settings.cpu.y_temp, cputemp .. "°C", 12, main_text_color)
    write(settings.cpu.x-settings.cpu.width_fan-settings.line.start, settings.cpu.y_fan, cpufanspeed .. " RPM", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y1, cpu1 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y2, cpu2 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y3, cpu3 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y4, cpu4 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y5, cpu5 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y6, cpu6 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y7, cpu7 .. "%", 12, main_text_color)
    write(settings.cpu.x_values, settings.cpu.y8, cpu8 .. "%", 12, main_text_color)
    write(settings.cpu.x-settings.cpu.width_temp-settings.line.start, settings.cpu.y_total, cpu .. "%", 12, main_text_color)

    -- cpu titles
    write(settings.cpu.x-120, settings.cpu.y_temp-settings.line.height, "CPU temperature", 12, main_text_color)
    write(settings.cpu.x-105, settings.cpu.y_fan-settings.line.height, "CPU fan speed", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y1-settings.line.height, "CPU1", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y2-settings.line.height, "CPU2", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y3-settings.line.height, "CPU3", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y4-settings.line.height, "CPU4", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y5-settings.line.height, "CPU5", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y6-settings.line.height, "CPU6", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y7-settings.line.height, "CPU7", 12, main_text_color)
    write(settings.cpu.x-settings.line.interval , settings.cpu.y8-settings.line.height, "CPU8", 12, main_text_color)
    write(settings.cpu.x-75, settings.cpu.y_total-settings.line.height, "total CPU", 12, main_text_color)

    -- processes list by cpu consumption
    write_list_proccesses_cpu(settings.cpu.x-settings.line.width2, settings.cpu.y1-settings.line.height, 20, 10, 12, main_text_color)
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

    write_list_proccesses_mem(settings.mem.x-settings.line.width1, settings.mem.y, 20, 10, 12, main_text_color)
end

function draw_disks()
    local ssdtemp       = ssd_temperature()
    local root          = string.format("SSD:  %s / %s", fs_used("/"), fs_size("/"))
    local jodibooks     = string.format("jodibooks-share:  %s / %s", fs_used("/media/jodibooks-share"), fs_size("/media/jodibooks-share"))
    local joediapna     = string.format("joediapna-share:  %s / %s", fs_used("/media/joediapna-share"), fs_size("/media/joediapna-share"))
    local user          = string.format("user-share:  %s / %s", fs_used("/media/joep"), fs_size("/media/joep"))
    local rootperc      = fs_used_perc("/")
    local jodibooksperc = fs_used_perc("/media/jodibooks-share")
    local joediapnaperc = fs_used_perc("/media/joediapna-share")
    local userperc      = fs_used_perc("/media/joep")

    --rectangle_rightleft(settings.disk.x, settings.disk.y_temp, settings.disk.width_temp, settings.line.thickness, ssdtemp, 70, color_frompercent(tonumber(ssdtemp)/70))
    rectangle_rightleft(settings.disk.x, settings.disk.y1, settings.line.width1, settings.line.thickness, rootperc, 100, color_frompercent(tonumber(rootperc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y2, settings.line.width1, settings.line.thickness, jodibooksperc, 100, color_frompercent(tonumber(jodibooksperc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y3, settings.line.width1, settings.line.thickness, joediapnaperc, 100, color_frompercent(tonumber(joediapnaperc)))
    rectangle_rightleft(settings.disk.x, settings.disk.y4, settings.line.width1, settings.line.thickness, userperc, 100, color_frompercent(tonumber(userperc)))

    --write(settings.disk.x-260, settings.disk.y1+400, ssdtemp, 12, main_text_color)
    write(settings.disk.x-260, settings.disk.y1-settings.line.height, root, 12, main_text_color)
    write(settings.disk.x-260, settings.disk.y2-settings.line.height, jodibooks, 12, main_text_color)
    write(settings.disk.x-260, settings.disk.y3-settings.line.height, joediapna, 12, main_text_color)
    write(settings.disk.x-260, settings.disk.y4-settings.line.height, user, 12, main_text_color)
    write(settings.disk.x-settings.line.width1-settings.line.start, settings.disk.y1, rootperc .. "%", 12, main_text_color)
    write(settings.disk.x-settings.line.width1-settings.line.start, settings.disk.y2, jodibooksperc .. "%", 12, main_text_color)
    write(settings.disk.x-settings.line.width1-settings.line.start, settings.disk.y3, joediapnaperc .. "%", 12, main_text_color)
    write(settings.disk.x-settings.line.width1-settings.line.start, settings.disk.y4, userperc .. "%", 12, main_text_color)

    local vals = {
        "Disk I/O:  " .. diskio(""),
        "    Read:  " .. diskio_read(""),
        "    Write: " .. diskio_write(""),
    }
    write_line_by_line(settings.disk.x-settings.line.width1, settings.disk.y, 20, vals, main_text_color, 12, false)
end

function draw_net()
    rectangle_rightleft(settings.net.down_x, settings.net.down_y, settings.net.width, settings.line.thickness, download_speed_kb(), download_rate_maximum, main_fg)
    rectangle_rightleft(settings.net.down_x, settings.net.up_y, settings.net.width, settings.line.thickness, upload_speed_kb(), upload_rate_maximum, main_fg)

    write(settings.net.down_x - 200, settings.net.down_y-settings.line.height, "Total download: ".. download_total(), 12, main_text_color)
    write(settings.net.down_x - 200, settings.net.up_y-settings.line.height, "Total upload: " .. upload_total(), 12, main_text_color)
    write(settings.net.down_x - settings.net.width-settings.line.start, settings.net.down_y, download_speed(), 12, main_text_color)
    write(settings.net.down_x - settings.net.width-settings.line.start, settings.net.up_y, upload_speed(), 12, main_text_color)
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