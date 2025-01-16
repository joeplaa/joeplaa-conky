----------------------------------
-- Author:      Zineddine SAIBI
-- Software:    Namoudaj Conky
-- Type:        Template for Conky
-- Version:     0.2 (11 Dec 2021)
-- License:     GPL-3.0
-- Repository:  https://www.github.com/SZinedine/namoudaj-conky
----------------------------------

require "cairo"
require "imlib2"
require "settings"
require "env"

function image(x, y, file)
    if file == nil then return end

    local show = imlib_load_image(file)
    if show == nil then return end

    imlib_context_set_image(show)
    imlib_render_image_on_drawable(x, y)
    imlib_free_image()
    show = nil
end


function line(startx, starty, endx, endy, thick, color, alpha)
    cairo_set_line_width (cr, thick)
    cairo_set_line_cap  (cr, CAIRO_LINE_CAP_BUTT)
    cairo_set_source_rgba (cr, color_convert(color, alpha))
    cairo_move_to (cr, startx, starty)
    cairo_line_to (cr, endx, endy)
    cairo_stroke (cr)
end

function draw_graph(data, max_value, table_length, blx, bly, red, green, blue, alpha, width, cheight)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_set_line_width (cr, width)
    for i = 1, table_length do

        -- Calculate bar height.
        bar_height = (cheight / max_value) * data[i]

        -- Set start position for each bar, and modify with the value
        -- of "i".
        cairo_move_to (cr, blx + (width / 2) + ((i - 1) * width), bly)

        -- Draw relative line, y becomes equal to bar height and
        -- must be negative to draw up. 
        cairo_rel_line_to (cr, 0, bar_height*-1)

        -- Draw the line.
        cairo_stroke (cr)
    end
end

function ring_clockwise(x, y, radius, thickness, angle_begin, angle_end, value_str, max_value, fg_color)
    local value = tonumber(value_str)
    if value > max_value then value = max_value end

    angle_begin = angle_begin * (2 * math.pi / 360) - (math.pi / 2)
    angle_end   = angle_end   * (2 * math.pi / 360) - (math.pi / 2)
    local progress = (value / max_value) * (angle_end - angle_begin)

    cairo_set_line_width (cr, thickness)
    cairo_set_source_rgba (cr, color_convert(main_bg, main_bg_alpha))
    cairo_arc (cr, x, y, radius, angle_begin, angle_end)
    cairo_stroke (cr)

    cairo_set_line_width (cr, thickness)
    cairo_set_source_rgba (cr, color_convert(fg_color, main_fg_alpha))
    cairo_arc(cr, x, y, radius, angle_begin, angle_begin + progress)
    cairo_stroke (cr)
end


function ring_anticlockwise(x, y, radius, thickness, angle_begin, angle_end, value_str, max_value, fg_color)
    local value = tonumber(value_str)
    if value > max_value then value = max_value end

    angle_begin = angle_begin * (2 * math.pi / 360) - (math.pi / 2)
    angle_end   = angle_end   * (2 * math.pi / 360) - (math.pi / 2)
    local progress = (value / max_value) * (angle_end - angle_begin)

    cairo_set_line_width (cr, thickness)
    cairo_set_source_rgba (cr, color_convert(main_bg, main_bg_alpha))
    cairo_arc_negative (cr, x, y, radius, angle_begin, angle_end)
    cairo_stroke (cr)

    cairo_set_line_width (cr, thickness)
    cairo_set_source_rgba (cr, color_convert(fg_color, main_fg_alpha))
    cairo_arc_negative (cr, x, y, radius, angle_begin, angle_begin + progress)
    cairo_stroke (cr)
end


function rectangle_leftright(x, y, len, thick, value_str, max_value, color)
    local value = tonumber(value_str)
    if value > max_value then value = max_value end

    cairo_set_source_rgba(cr, color_convert(main_bg, main_bg_alpha))
    cairo_rectangle(cr, x, y, len, thick)
    cairo_fill(cr)

    local progress = (len / max_value) * value
    cairo_set_source_rgba(cr, color_convert(color, main_fg_alpha))
    cairo_rectangle(cr, x, y, progress, thick)
    cairo_fill(cr)
end


function rectangle_rightleft(x, y, len, thick, value_str, max_value, color)
    rectangle_leftright(x, y, -len, thick, value_str, max_value, color)
end


function rectangle_bottomup(x, y, len, thick, value_str, max_value, color)
    local value = tonumber(value_str)
    if value > max_value then value = max_value end

    cairo_set_source_rgba(cr, color_convert(main_bg, main_bg_alpha))
    cairo_rectangle(cr, x, y, thick, -len)
    cairo_fill(cr)
    cairo_set_source_rgba(cr, color_convert(color, main_fg_alpha))

    local progress = (len / max_value) * value
    cairo_rectangle(cr, x, y, thick, -progress)
    cairo_fill(cr)
end


function rectangle_upbottom(x, y, len, thick, value_str, max_value, color)
    rectangle_bottomup(x, y, -len, thick, value_str, max_value, color)
end


function write(x, y, text, font_size, color, align)
    _write_(x, y, text, main_font, font_size, color, 1, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, align)
end


function write_bold(x, y, text, font_size, color, align)
    -- convenience function to write in bold font
    _write_(x, y, text, main_font, font_size, color, 1, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD, align)
end


function _write_(x, y, text, font_name, font_size, color, alpha, font_slant, font_face, align)
    cairo_select_font_face (cr, font_name, font_slant, font_face);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, color_convert(color, alpha))

    local x_align
    local extents = cairo_text_extents_t:create()
    tolua.takeownership(extents)
    cairo_text_extents(cr, text, extents)

    if align == "l" then x_align = x                                                   -- align left
    elseif align == "c" then x_align = x / 2 - (extents.width / 2 + extents.x_bearing) -- align center
    elseif align == "r" then x_align = x - (extents.width + extents.x_bearing)         -- align right
    else x_align = x                                                                   -- align left (default)
    end

    cairo_move_to (cr, x_align, y)
    cairo_show_text (cr, text)
    cairo_stroke (cr)
end


-- return a process according to its CPU consumption
function getProcessN(n)
    local name = parse("top name " .. n)
    local perc = parse("top cpu " .. n)
    local time = parse("top time " .. n)
    return name .. perc .. "% " .. time
end


-- return a process according to its memory consumption
function getMemoryN(n)
    local name = parse("top_mem name " .. n)
    local perc = parse("top_mem mem " .. n)
    local amount = parse("top_mem mem_res " .. n)
    return name .. perc .. '% ' .. amount
end


function write_list_proccesses_cpu(x, y, interval, nb_todisplay, font_size, color)
    local array = {}
    for i = 1, nb_todisplay do
        table.insert(array, getProcessN(i))
    end
    write_line_by_line(x, y, interval, array, color, font_size, false)
end


-- convenience function to write a list of running processes
function write_list_proccesses_mem(x, y, interval, nb_todisplay, font_size, color)
    local array = {}
    for i = 1, nb_todisplay do
        table.insert(array, getMemoryN(i))
    end
    write_line_by_line(x, y, interval, array, color, font_size, false)
end


-- write text in multiple lines.
-- the text is contained in `content_array` where each entry is a line separated with `interval`
function write_line_by_line(x, y, interval, content_array, color, font_size, bold)
    if bold == nil then bold = false end
    local yy = y
    for i in pairs(content_array) do
        if bold then write_bold(x, yy, content_array[i], font_size, color)
        else         write(x, yy, content_array[i], font_size, color)
        end
        yy = yy + interval
    end
end


-- convinience function
function parse(str)
    return conky_parse(string.format("${%s}", str))
end


-- return a color according to the provided value (threshold)
-- the colors are defined in "settings.lua"
function color_frompercent(percent)
    local perc = tonumber(percent)
    if     perc > threshold_critical then return color_critical
    elseif perc > threshold_warning  then return color_warning
    else                                     return color_normal
    end
end


function color_convert(colour, alpha)
    -- input hexadecimal color code, returns its corresponding RGB+Alpha representation
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function break_after_first_word(string, delimiter)
    local first_word = ""
    local start, endpos = string.find(string, delimiter, 1)
    if start ~= nil then
        first_word = string.sub(string, 1, start -1)
    end

    return first_word
end

-- functions to fetch some important system info
-- for other variables, see: <http://conky.sourceforge.net/variables.html>
function updates()              return parse("updates") end
function kernel()               return parse("kernel") end                  --  ex: 5.10.32-1-lts
function system_name()          return parse("sysname") end                 --  ex: Linux
function hostname()             return parse("nodename") end                --  ex: Hostname
function os()                   return parse("execi 86400 lsb_release -sd") end --  ex: Ubuntu 20.04.3 LTS
--function arch()                 return parse("machine") end                 --  ex: x86_64
function desktops()             return parse("desktop_number") end          --  total number of desktops
function desktop()              return parse("desktop") end                 --  ex: 3 (current desktop)
--function desktop_name()         return parse("desktop_name") end            --  ex: Desktop 3
--function username()             return parse("user_names") end
function cpu_name()             return parse("exec cat /proc/cpuinfo | grep 'name'| uniq | cut -c 14-54") end
function cpu_temperature()      return parse("hwmon 2 temp 1") end --  temperature in C°
--function cpu_fanspeed()         return parse("hwmon 2 fan 2") end --  speed in RPM
function cpu_percent(n)
    if n == nil or n == "" then return parse("cpu") end
    if n > 0 and n <= cpu_threads    then return parse("cpu cpu" .. n)
    else                        return nil end
end
function cpu_freq(n)
    if n == nil or n == "" then return parse("freq") end
    if n > 0 and n <= cpu_threads    then return parse("freq " .. n)
    else                        return nil end
end
function ssd_temperature()      return parse("hwmon 1 temp 1") end        --  temperature in C°
function fs_used(fs)
    if fs == nil           then return nil
    else                        return parse("fs_used " .. fs)
    end
end
function fs_used_perc(fs)
    if fs == nil           then return nil
    else                        return parse("fs_used_perc " .. fs)
    end
end
function fs_size(fs)
    if fs == nil           then return nil
    else                        return parse("fs_size " .. fs)
    end
end
function fs_free_perc(fs)
    if fs == nil           then return nil
    else                        return parse("fs_free_perc " .. fs)
    end
end
function fs_free(fs)
    if fs == nil           then return nil
    else                        return parse("fs_free " .. fs)
    end
end
function gpu_name(gpu)          return "NVIDIA " .. parse("exec nvidia-smi --query-gpu=gpu_name --format=csv | sed -n " .. gpu + 1 .. "p") end
function gpu_temp(gpu)          return parse("execi 1 nvidia-smi --query-gpu=temperature.gpu --format=csv | sed -n " .. gpu + 1 .. "p") end
function gpu_fanspeed(gpu)      return parse("execi 1 nvidia-smi --query-gpu=fan.speed --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_utilization(gpu)   return parse("execi 1 nvidia-smi --query-gpu=utilization.gpu --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_decode(gpu)        return parse("execi 1 nvidia-smi --query-gpu=utilization.decoder --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_encode(gpu)        return parse("execi 1 nvidia-smi --query-gpu=utilization.encoder --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_mem_util(gpu)      return parse("execi 1 nvidia-smi --query-gpu=utilization.memory --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_mem_used(gpu)      return parse("execi 1 nvidia-smi --query-gpu=memory.used --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_mem_total(gpu)     return parse("execi 1 nvidia-smi --query-gpu=memory.total --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_power_draw(gpu)    return parse("execi 1 nvidia-smi --query-gpu=power.draw --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
function gpu_power_limit(gpu)   return parse("execi 1 nvidia-smi --query-gpu=power.limit --format=csv | sed -n " .. gpu + 1 .. "p | cut -d ' ' -f 1") end
-- function vm_used(vm)            return parse("execi 60 virsh vol-info " .. vm .. " --pool " .. pool_name .. " | grep Allocation | awk '{print$2 $3}'") end
-- function vm_size(vm)            return parse("execi 60 virsh vol-info " .. vm .. " --pool " .. pool_name .. " | grep Capacity | awk '{print$2 $3}'") end
-- function vm_used_perc(vm)
--     local allocation = tonumber(parse("execi 60 virsh vol-info " .. vm .. " --pool " .. pool_name .. " | grep Allocation | awk '{print$2}'"))
--     local capacity = tonumber(parse("execi 60 virsh vol-info " .. vm .. " --pool " .. pool_name .. " | grep Capacity | awk '{print$2}'"))
--     if allocation == nil or capacity == nil    then return 0
--     else                        return math.modf(allocation / capacity * 100)
--     end
-- end
function load_avg()             return parse("loadavg") end                             --  system load averages
--function running_threads()      return parse("running_threads") end
--function memory_name()          return parse("exec sudo dmidecode --type memory | grep -m1 Manufacturer | cut -c 16-23") .. " " .. parse("exec sudo dmidecode --type memory | grep -m1 'Part Number' | cut -c 15-29") end
function memory()               return parse("mem") end                                 --  amount of memory in use
function memory_percent()       return parse("memperc") end                             --  percentage of memory in use
function memory_max()           return parse("memmax") end                              --  total amount of memory
function memory_cached()        return parse("cached") end                              --  amount of memory cached
function memory_buffers()       return parse("buffers") end                             --  amount of memory buffered
function swap()                 return parse("swap") end
function swap_max()             return parse("swapmax") end
function swap_percent()         return parse("swapperc") end
--function sys_temp_in()          return parse("hwmon 2 temp 1") end                      --  temperature in C°
function pch_temperature()      return parse("hwmon 4 temp 1") end --  temperature in C°
function acpi_temperature()     return parse("hwmon 0 temp 1") end --  temperature in C°
--function sys_fanspeed1()        return parse("hwmon 2 fan 1") end                       --  speed in RPM
--function sys_fanspeed2()        return parse("hwmon 2 fan 3") end                       --  speed in RPM
function download_speed()       return parse("downspeed " .. net_interface) .. "/s" end   --  ex: 930B or 3kb
function download_speed_raw()   return parse("downspeedf " .. net_interface) end
function download_total()       return parse("totaldown " .. net_interface) end
--function downspeedgraph()       return parse("downspeedgraph" .. net_interface) end
function upload_speed()         return parse("upspeed " .. net_interface) .. "/s" end     --  ex: 930B or 3kb
function upload_speed_raw()     return parse("upspeedf " .. net_interface) end
function upload_total()         return parse("totalup " .. net_interface) end
--function upspeedgraph()         return parse("upspeedgraph" .. net_interface) end
function local_ip4_lan()        return parse("addrs " .. net_interface) end               --  ex: 192.168.178.25
function local_ip6_lan()        return parse("v6addrs " .. net_interface) end               --  ex: 
function download_speed2()      return parse("downspeed " .. net_interface2) .. "/s" end   --  ex: 930B or 3kb
function download_speed_raw2()  return parse("downspeedf " .. net_interface2) end
function download_total2()      return parse("totaldown " .. net_interface2) end
--function downspeedgraph2()     return parse("downspeedgraph" .. net_interface2) end
function upload_speed2()        return parse("upspeed " .. net_interface2) .. "/s" end     --  ex: 930B or 3kb
function upload_speed_raw2()    return parse("upspeedf " .. net_interface2) end
function upload_total2()        return parse("totalup " .. net_interface2) end
--function upspeedgraph2()        return parse("upspeedgraph" .. net_interface2) end
function local_ip6_san()        return parse("v6addrs " .. net_interface2) end               --  ex: 
function uptime()               return parse("uptime") end                              --  ex: 2d 13h 40m
function time_hrmin()           return parse("time %R") end                             --  ex: 15:40
function time_hrminsec()        return parse("time %T") end                             --  ex: 15:30:25
function time_day()             return parse("time %A") end                             --  ex: saturday
function time_day_short()       return parse("time %a") end                             --  ex: sat
function time_month()           return parse("time %B") end                             --  ex: january
function time_month_short()     return parse("time %b") end                             --  ex: jan
function time_month_number()    return parse("time %d") end                             --  ex: 1
function time_year()            return parse("time %Y") end                             --  ex: 2021
function diskio(device)         return parse("diskio " .. device) .. "/s" end           --  device ex: /dev/sda
function diskio_read(device)    return parse("diskio_read " .. device) .. "/s" end
function diskio_write(device)   return parse("diskio_write " .. device) .. "/s" end
--function diskiograph(device)    return parse("diskiograph " .. device) .. "/s" end      --  device ex: /dev/sda
function fetch_public_ip(type)
    local po = nil
    if type == 4 then
        po = io.popen("curl -4 -s https://ipinfo.io/ip")
        -- po = io.popen("curl -4 -s ifconfig.me/ip")
        -- po = io.popen("curl -4 -s ident.me")
        -- po = io.popen("curl -4 -s api.ipify.org")
    else
        po = io.popen("curl -s https://v6.ipinfo.io/ip")
    end
---@diagnostic disable-next-line: need-check-nil
    local content = po:read("*a")
    if content == nil or content == "" then
        return "None"
    else
        return content
    end
end
function fetch_vpn_ip(type)
    local po = io.popen("curl -" .. type .. " -s ident.me")
---@diagnostic disable-next-line: need-check-nil
    local content = po:read("*a")
    if content == nil or content == "" then
        return "None"
    else
        return content
    end
end

--- IPMI ---

--Dell servers
--TEMP_SENSOR="04h"  # Inlet Temp
--TEMP_SENSOR="01h"  # Exhaust Temp
--TEMP_SENSOR="0Eh"  # CPU 1 Temp
--TEMP_SENSOR="0Fh"  # CPU 2 Temp
function dell_cpu_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -P " .. pw .. " sdr type temperature | grep 0Eh | cut -d'|' -f5 | cut -d' ' -f2")) or 0  end
function dell_inlet_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -P " .. pw .. " sdr type temperature | grep 04h | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function dell_fan_speed(ip, user, pw, fan) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -P " .. pw .. " sensor reading " .. fan .. " | awk '{ print $NF }'")) or 0 end
function dell_pwr(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -P " .. pw .. " sdr type current | grep 77h | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end

--HP servers
--TEMP_SENSOR="03h"  # Inlet Temp
--TEMP_SENSOR="04h"  # CPU 1 Temp
--TEMP_SENSOR="05h"  # CPU 2 Temp
--TEMP_SENSOR="0Ah"  # HD Max Temp
--TEMP_SENSOR="0Ch"  # Chipset Temp
--TEMP_SENSOR="1Dh"  # HD Controller Temp
function hp_cpu1_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type temperature | grep 04h | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function hp_cpu2_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type temperature | grep 05h | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function hp_inlet_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type temperature | grep 03h | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function hp_pch_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type temperature | grep 0Ch | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function hp_fan_speed(ip, user, pw, fan)
    local fanspeed = parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sensor reading " .. fan .. " | awk '{ print $NF }'")
    local fs1, fs2 = fanspeed:match("([^.]+).([^.]+)")
    return (tonumber(fs1 or 0) * 1000 + tonumber(fs2 or 0)) / 1000
end
function hp_pwr(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type current | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end

--Supermicro servers
--TEMP_SENSOR="01h"  # CPU Temp
--TEMP_SENSOR="0Ah"  # PCH Temp
--TEMP_SENSOR="0Bh"  # System Temp
--TEMP_SENSOR="0Ah"  # Peripheral Temp
function sm_cpu_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type temperature | grep 01h | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function sm_pch_temp(ip, user, pw) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sdr type temperature | grep 0Ah | cut -d'|' -f5 | cut -d' ' -f2")) or 0 end
function sm_fan_speed(ip, user, pw, fan) return tonumber(parse("execi 60 ipmitool -C 3 -I lanplus -H " .. ip .. " -U " .. user .. " -L USER -P " .. pw .. " sensor reading " .. fan .. " | awk '{ print $NF }'")) or 0 end

function server_hostname(server) return parse("execi 10 ssh " .. server .. " 'cat /proc/sys/kernel/hostname'") end
function server_kernel(server) return parse("execi 10 ssh " .. server .. " 'uname -r'") end
function server_os(server) return parse("execi 10 ssh " .. server .. " 'lsb_release -sd'") end
-- https://stackoverflow.com/a/69261076
function server_uptime(server) return parse("execi 10 ssh " .. server .. " uptime -p | sed 's/up\\s*//g' | sed 's/\\s*weeks/w/g' | sed 's/\\s*week/w/g' | sed 's/\\s*days/d/g' | sed 's/\\s*day/d/g' | sed 's/\\s*hours/h/g' | sed 's/\\s*minutes/m/g'") end