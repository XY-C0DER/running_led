module	flow_led
#(
	parameter	cnt_max = 25'd24_999_999
)
(
	input	wire	sys_clk,
	input	wire	sys_rst,
	
	output	wire    [3:0]	led_out
);

reg	[24:0] 	count;
reg	[3:0]	led_flow = 4'b0001;

always@(posedge	sys_clk	or	negedge	sys_rst)
	if(sys_rst	==	1'b0)
		count	<=	1'b0;
	else	if((sys_rst == 1'b1)&&(count == cnt_max-1))
		count	<=	25'd0;
	else
		count	<=	count + 1;
		
//always@(posedge	sys_clk	or	negedge	sys_rst)
//	if(sys_rst	==	1'b0)
//		led_flow <=	4'b0001;
//	else	if((led_flow == 4'b1000)&&(count == cnt_max-1))
//		led_flow <= 4'b0001;
//	else	if(count == cnt_max-1)
//		led_flow <= led_flow <<	1'b1;

always@(posedge	sys_clk	or	negedge	sys_rst)
	if(sys_rst	==	1'b0)
		led_flow <=	4'b0001;
	else	case(led_flow)
		4'b0001:if(count == cnt_max-1)
					led_flow<=4'b0010;
		4'b0010:if(count == cnt_max-1)
					led_flow<=4'b0100;
		4'b0100:if(count == cnt_max-1)
					led_flow<=4'b1000;
		4'b1000:if(count == cnt_max-1)
					led_flow<=4'b0001;
	default:led_flow<=4'b0001;
	endcase

	
assign	led_out	= ~led_flow;
	
endmodule