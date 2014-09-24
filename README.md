# ForemanGraphite

Adds graphite support for [Foreman](http://theforeman.org).

This Foreman plugin allows to use graphite to track performance metrics of your foreman instances.

You will need to install a graphite instance to use this plugin.

## Configuration

The graphite host(s) and options can be changed by adding settings to `/usr/share/foreman/config/settings.plugins.d/foreman-graphite.yaml`, or Foreman's own `settings.yaml`.

Example config file:

```yaml
:graphite:
  :server: graphite:2003
    # results are aggregated in n seconds slices, defaults to 60
    :slice: 60
    # send to graphite every n seconds - defaults to 60
    :interval: 60
    # set the max age in seconds for records reanimation, defaults to  4 * 60 * 60
    :cache: 4 * 60 * 60
```

## Copyright
   
Copyright (c) 2014 Ohad Levy
   
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
   
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
   
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
