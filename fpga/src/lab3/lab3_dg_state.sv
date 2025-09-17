module lab3_dg_state(input logic int_osc,
            input logic reset,
            input logic [3:0] rows,
            input logic [3:0] sync,
            output logic [3:0] cols, 
            output logic [7:0] keypress,
            output logic [3:0] rowpress,
            output logic alarm);

typedef enum logic [3:0] {idle, waiter, check, drive, last} statetype;
logic [3:0] holdcols;
statetype state, nextstate; 
integer v;
logic [3:0] srows;
logic [7:0] prekey; 
logic [19:0] counter1;

always_ff @(posedge int_osc) begin
	if (~reset) begin
		cols <= 4'b1111;
		rowpress <=4'b1111;
		state <= idle;
		v <= 0;
	end 
    else begin
		cols <= holdcols;
		state <= nextstate;
		if (state == idle) begin
			if (rows != 4'b1111) begin
				rowpress <= rows;
			end
			else rowpress <= 4'b1111;
			if (v == 3) begin
				v <= 0;
			end
			else v <= v + 1;
				 

		end
	end
end

always_ff @(posedge int_osc) begin
    if (~reset) begin
        srows    = 4'b1111;
        counter1 = 20'd0;
    end
    else if (state == waiter) begin
		if (counter1 == 20'd480000) begin
            srows = sync;  
			keypress = {holdcols, srows};			
        end
        else begin
            counter1 = counter1 + 20'd1;
        end
    end
	else counter1 = 20'd0;
end

// next state logic
always_comb begin
    nextstate = state;
    alarm     = 1'b0;
case (state)
idle: begin
holdcols = 4'b1111;
holdcols[v] = 1'b0; 
//if (v == 3) begin
	if (rows != 4'b1111) begin    
		prekey    = {holdcols, rowpress};
		nextstate = waiter;
	end
//end
else nextstate = idle; 
end


waiter: begin
if (counter1 == 20'd480000) begin
//keypress = {cols, srows};
nextstate = check;
end
else begin
nextstate = waiter;
 end
    end
    check: begin
    if (srows != rowpress) begin
		alarm = 1'b0;
        nextstate = idle;
    end 
    else begin
        alarm = 1'b1;  
        nextstate = drive; 
    end 
    end
    drive: begin
		alarm = 1'b1;
        nextstate = last; 
    end
last: begin
    if (rows == 4'b1111)
        nextstate = idle;
    else if (rows != rowpress)  
        nextstate = idle;
    else begin
		alarm = 1'b1; 
        nextstate = last;
	end

end
endcase
end
endmodule



