`ifndef __TOP_SV__
`define __TOP_SV__

module top ();

    string status;
    int delay;

    initial begin
        $timeformat(-9, 2, " ns");
        
        $display("TEST START TIME: %0t", $realtime);

        void'($value$plusargs("STATUS=%s", status));        
    
        case (status)
            "PASS": $display("Test: PASS");
            "FAIL": $display("Test: FAIL");
            "FATAL": $display("Test: FATAL");
            default:  $display("Test: UNKNOWN");
        endcase

        delay = $urandom_range(100000, 1000);
        
        #(1ps*delay) $display("TEST FINISH TIME: %0t", $realtime);
    end

    
endmodule: top

`endif // __TOP_SV__
