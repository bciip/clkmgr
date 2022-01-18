// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

<%
from collections import OrderedDict

clks_attr = cfg['clocks']
grps = clks_attr['groups']
## MY_EDIT :begin (commented num_hints after removing kmac & hmac)
##num_hints = len(hint_clks)
## MY_EDIT :end (commented num_hints after removing kmac & hmac)
%>

package clkmgr_pkg;

## MY_EDIT :begin (commented typedef hint_names_e after removing kmac & hmac)
##  typedef enum int {
##% for hint, v in hint_clks.items():
##    ${v['name'].capitalize()} = ${loop.index}${"," if not loop.last else ""}
##% endfor
##  } hint_names_e;
## MY_EDIT :end (commented typedef hint_names_e after removing kmac & hmac)

  typedef struct packed {
<%
# Merge Clock Dicts together
all_clocks = OrderedDict()
all_clocks.update(ft_clks)
## MY_EDIT :begin (commented all_clocks.update(hint_clks) after removing kmac & hmac)
##all_clocks.update(hint_clks)
## MY_EDIT :end (commented all_clocks.update(hint_clks) after removing kmac & hmac)
all_clocks.update(rg_clks)
all_clocks.update(sw_clks)
%>\
% for clk in all_clocks:
    logic ${clk};
% endfor

  } clkmgr_out_t;

% for intf, eps in export_clks.items():
  typedef struct packed {
  % for ep, clks in eps.items():
    % for clk in clks:
    logic clk_${intf}_${ep}_${clk};
    % endfor
  % endfor
  } clkmgr_${intf}_out_t;
% endfor
## MY_EDIT :begin (commented clk_hint typedef & parameter after removing kmac & hmac)
##  typedef struct packed {
##    logic [${num_hints}-1:0] idle;
##  } clk_hint_status_t;
##
##  parameter clk_hint_status_t CLK_HINT_STATUS_DEFAULT = '{
##    idle: {${num_hints}{1'b1}}
##  };
## MY_EDIT :end (commented clk_hint typedef & parameter after removing kmac & hmac)
endpackage // clkmgr_pkg
