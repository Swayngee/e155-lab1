module lab3_dg_state(input logic int_osc,
            input logic reset,
            input logic [3:0] rows,
            input logic [3:0] sync,
            output logic [3:0] cols, 
            output logic [7:0] keypress,
            output logic [3:0] rowpress,
            output logic alarm);

typedef enum logic [3:0] {idle, waiter, check, drive, last} statetype;

statetype state, nextstate; 
integer v;
logic [4:0] srows;
logic [3:0] rowpress;
logic [7:0] prekey; 
logic [7:0] keypress;
logic [20:0] counter;
logic alarm = 1'b0;

always_ff @(posedge int_osc or posedge reset) begin
    if (reset) begin
	    state <= idle;
        v <= 0;
    end 
    else if (state == idle) begin 
        if (v == 4)
        v <= 0;
        else 
        v <= v + 1;
    end
    else
        state <= nextstate;
end


always_ff @(posedge int_osc or posedge reset) begin
    if (reset) begin
        srows <= 4'b1111;
        counter <= 20'd0;
    end
    else if (state == waiter) begin
        if (sync == srows) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 20'd1;
            if (counter >= 10) begin
                srows <= sync;
                counter <= 20'd0;
            end
        end
    end
end

always_comb begin
nextstate = state;
case(state)
    idle: begin
        alarm = 1'b0;
        cols = 4'b1111;
        cols[v] = 1'b0;
        if (rows != 4'b1111) begin
            rowpress = ~rows;         
            prekey   = {cols, rowpress};
                nextstate = waiter;
            end
            else
                nextstate = idle;
        end 

    waiter: begin
    keypress = {cols, srows};
    nextstate = check;

    end
    check: begin
    if (keypress != prekey) begin 
        nextstate = idle;
    end 
    else begin
        alarm = 1'b1;  
        nextstate = drive; 
    end 
    end
    drive: begin
        nextstate = last; 
    end
    last: begin
        if (keypress == prekey)
            nextstate = last;
        else nextstate = idle; 
    end
endcase
end
endmodule