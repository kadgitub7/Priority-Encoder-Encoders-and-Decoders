`timescale 1ns / 1ps

module priorityEncoder_tb();
    reg I0,I1,I2,I3;
    wire Y0,Y1;
    
    priotityEncoder uut(I0,I1,I2,I3,Y0,Y1);
    integer i;
    initial begin
        for(i=0;i<16;i=i+1)begin
            {I3,I2,I1,I0} = i;
            #10 $display("I3 = %b, I2 = %b, I1 = %b, I0 = %b, Y1 = %b, Y0 = %b", I3,I2,I1,I0,Y1,Y0);
        end
    end
endmodule
