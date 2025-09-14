module lab3_dg_state(input logic int_osc,
            input logic reset,
            input logic [3:0] rows,
            output logic [3:0] cols, 
            output logic [7:0] keypress)

typedef enum logic [3:0] {idle, sync, check, drive, last} statetype;
statetype state, nextstate; 
integer v;

always_ff @(posedge int_osc or posedge reset) begin
    if (reset) begin
	    state <= idle;
        v <= 0;
    end 
    else if (state == idle) begin 
        if (v == 3)
        v <= 0;
        else 
        v <= v + 1;
    end
    else
        state <= nextstate;
end

logic [20:0] counter;

always_ff @(posedge int_osc or posedge reset) begin
    if (reset) begin
        srows <= 4'b1111;
        counter <= 20'd0;
    end
    else if (state == sync) begin
        if (rowpress == srows) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 20'd1;
            if (counter >= 10) begin
                srows <= rowpress;
                counter <= 20'd0;
            end
        end
    end
end


logic [3:0] rowpress;
logic [7:0] prekey;  

always_comb begin
nextstate = state;
case(state)
    idle: begin
        cols = 4'b1111;
        cols[v] = 1'b0;
        if (rows != 4'b1111) begin
            rowpress = ~rows;         
            prekey   = {cols, rowpress};
                nextstate = sync;
            end
            else
                nextstate = idle;
        end 

logic [7:0] keypress;

    sync: begin

    keypress = {cols, srows};
    nextstate = check;

    end
    check: begin
    if (keypress != prekey)begin 
        nextstate = idle;
    end 
    else begin 
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