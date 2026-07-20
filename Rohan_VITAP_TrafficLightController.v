`timescale 1ns / 1ps


module Rohan_VITAP_TrafficLightController(
    input clk,
    input rst,
  output reg [1:0] north,
  output reg [1:0] south,
  output reg [1:0] east,
  output reg [1:0] west
    );
       
    reg [1:0] pst, nst;
    reg [3:0] count;//count to give input , to give soem delay for green red and yellow lights 

    parameter S0 = 2'b00,//different states , stages used in the fsm
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    
    parameter RED    = 2'b00,
              YELLOW = 2'b01,
              GREEN  = 2'b10;//giving the colors their 2bit codes



    always @(posedge clk)
    begin
        if (rst)
          pst <= S0;// if rst reseting the entire fsm logic to S0 (first statye again)
        else
            pst <= nst;
    end

    always @(posedge clk)
    begin
        if (rst)
            count <= 0;

        else if (pst != nst)
            count <= 0;

        else
            count <= count + 1;
    end


    always @(pst, count)
    begin

        case(pst)

           
            S0: begin
              if (count >= 9)//giving 9ns of delay to green light
                    nst = S1;
                else
                    nst = S0;
            end


            
            S1: begin
              if (count >= 2)//giving 2ns of delay to yellow light
                    nst = S2;
                else
                    nst = S1;
            end


            
            S2: begin
                if (count >= 9)
                    nst = S3;
                else
                    nst = S2;
            end


            
            S3: begin
                if (count >= 2)
                    nst = S0;
                else
                    nst = S3;
            end


            default: begin
                nst = S0;
            end

        endcase

    end


    always @(pst)
    begin

        case(pst)

            S0: begin
                north = GREEN;
                south = GREEN;
                east  = RED;
                west  = RED;
            end


            S1: begin
                north = YELLOW;
                south = YELLOW;
                east  = RED;
                west  = RED;
            end


            S2: begin
                north = RED;
                south = RED;
                east  = GREEN;
                west  = GREEN;
            end


            S3: begin
                north = RED;
                south = RED;
                east  = YELLOW;
                west  = YELLOW;
            end


            default: begin
                north = RED;
                south = RED;
                east  = RED;
                west  = RED;
            end

        endcase

    end
endmodule
