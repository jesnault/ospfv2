#--
# Copyright 2010 Jean-Michel Esnault.
# All rights reserved.
# See LICENSE.txt for permissions.
#
#
# This file is part of OSPFv2.
# 
# OSPFv2 is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# OSPFv2 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with OSPFv2.  If not, see <http://www.gnu.org/licenses/>.
#++

require 'lsa/lsa'
require 'lsa/router'
require 'lsa/network'
require 'lsa/summary'
require 'lsa/external'

module OSPFv2
  class Lsa
    class << self
      def factory(arg)
        if arg.is_a?(String)
          return unless (arg.size>=20)
          case arg[3]
          when 1 ; OSPFv2::Router.new_ntop(arg)
          when 2 ; OSPFv2::Network.new_ntop(arg)
          when 3 ; OSPFv2::Summary.new_ntop(arg)
          when 4 ; OSPFv2::AsbrSummary.new_ntop(arg)
          when 5 ; OSPFv2::AsExternal.new_ntop(arg)
          when 7 ; OSPFv2::AsExternal7.new_ntop(arg)
          end
        elsif arg.is_a?(Hash)
          case arg[:ls_type]
          when :router_lsa        ; OSPFv2::Router.new_hash(arg)
          when :network_lsa       ; OSPFv2::Network.new_hash(arg)
          when :summary_lsa       ; OSPFv2::Summary.new_hash(arg)
          when :asbr_summary_lsa  ; OSPFv2::AsbrSummary.new_hash(arg)
          when :as_external_lsa   ; OSPFv2::AsExternal.new_hash(arg)
          when :as_external7_lsa  ; OSPFv2::AsExternal7.new_hash(arg)
          end
        elsif arg.is_a?(Lsa)
          factory(arg.encode)
        end
      end
    end
  end
  
end
