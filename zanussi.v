module zanussi(clk,start,item1,item2,item3,item4,led1,led2,led3, motor, buzzer, waterPump, hex, iHex);
input 	start;
input 	clk;
input 	item1,item2,item3,item4;
wire		item1,item2,item3,item4;
wire 		start,clk;
output  	led1 = 0;
output  	led2 = 0;
output	led3 = 0;
output	buzzer;
output	motor = 0;
output	waterPump = 0;
output	[6:0]hex;
output	[6:0]iHex;
reg		[6:0]hex;
reg		[6:0]iHex;
reg  		led1,led2,led3;
reg 		[1:0]stage_counter = 0;
reg		[32:0]tiktok;
reg		motor;	
reg		buzzer;
reg		waterPump;


always @(posedge clk) begin
	if(start == 1) begin
		if( (item1+item2+item3+item4) == 4)  begin
			if(tiktok < 5*50_000_000) begin//5 Seconds
				tiktok <= tiktok + 1;			
			end
			else begin
				tiktok <= 0;			
				case(stage_counter)		
					2'b00://Stage 1 (Fill Water)
					begin 
						buzzer = 0;
						waterPump=1;
						led1=1;
						hex=7'b111_1001;//1
					end
					2'b01://Stage 2 (Motor Rotation)
					begin
						waterPump = 0;
						motor=1;
						led1=0;
						led2=1;
						hex=7'b010_0100;//2
					end
					2'b10://Stage 3 (Rotate and dry)
					begin
						waterPump = 1;
						led2=0;
						led3=1;
						hex=7'b011_0000;
					end
					2'b11:
					begin//Start Buzzer
						waterPump = 0;
						motor=0;
						led3=0;
						buzzer=1;
						hex=7'b111_1111;
					end
					default:begin hex=7'b000_0000; iHex=7'b111_1111;end
				endcase
				stage_counter <= stage_counter + 1;
			end
		end//end items_counter
		else begin hex=7'b000_0110; end//ERROR*/
	end//end start
	case((item1+item2+item3+item4)) 
		3'b000:iHex=7'b100_0000;//0
		3'b001:iHex=7'b111_1001;//1
		3'b010:iHex=7'b010_0100;//2
		3'b011:iHex=7'b011_0000;//3
		3'b100:iHex=7'b001_1001;//4
	endcase
end//end always

endmodule 