#!/usr/bin/env ruby 
# Part of utility to convert HTMLed-XLS studienpläne into iCals.
# Copyright (C) 2016 Christoph criztovyl Schulz 
# 
# This program is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by 
# the Free Software Foundation, either version 3 of the License, or 
# (at your option) any later version. 
# 
# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
# GNU General Public License for more details. 
# 
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>. 
 

# This is a util module.
module StudienplanUtil

    # Formats a time string
    def formatTime(dateTime)
        # i.e Thu 12:30 15.03.2016 KW11
        dateTime.strftime("%a %H:%M %d.%m.%y KW%U")
    end

    # Formats as a day string
    def formatDay(date)
        date.strftime("%a %d.%m.%y")
    end

    # Formats as a from-to string
    def formatWeek(date)
        date = date - date.cwday + 1 # Monday
        date_ = date + 4 # Friday
        formatTime(date) + " - " + formatDay(date_)
    end

    def format_non_empty(obj, format="%s", empty="", opts=[])
        if obj.class.name == String.name 
            if obj.empty?
                ""
            else
                format % obj
            end
        elsif obj
            format % obj.to_s
        else
            empty
        end
    end

    def class_ical_name(clazz)
        name = clazz.jahrgang;
        name += "-" + clazz.full_name if clazz.full_name
        name += "-" + clazz.course if clazz.course
        name += "-" + clazz.cert if clazz.cert
        name
    end

    def json_object_keys(hash)
        ary = [[], {}]

        hash.each do |key,value|
            ary[0].push key
            ary[1].store ary[0].length-1, value
        end
        ary
    end
end

