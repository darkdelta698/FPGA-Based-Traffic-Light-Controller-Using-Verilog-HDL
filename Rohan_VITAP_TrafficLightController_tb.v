`timescale 1ns / 1ps

module Rohan_VITAP_TrafficLightController_tb;

    parameter CLOCK_PERIOD = 10;

    reg clk;
    reg rst;

  wire [1:0] north;
  wire [1:0] south;
  wire [1:0] east;
  wire [1:0] west;


    Rohan_VITAP_TrafficLightController dut (
        .clk(clk),
        .rst(rst),
        .north(north),
        .south(south),
        .east(east),
        .west(west)
    );



    initial begin
        clk = 0;

        forever #(CLOCK_PERIOD/2)
            clk = ~clk;
    end


    initial begin

        
        rst = 1;

        
        repeat(2)
            @(posedge clk);

        
        @(negedge clk);
        rst = 0;//need to amke rst 0 , that we are doing at thee negitive edge of the clk


        
        repeat(60)// Run FSM for 60 clock cycles
            @(posedge clk);


        $finish;

    end


    initial begin

        $monitor(
        "Time=%0t | rst=%b | North=%b | South=%b | East=%b | West=%b",
        $time, rst, north, south, east, west
        );

    end


endmodule