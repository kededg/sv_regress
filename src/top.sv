`ifndef __TOP_SV__
`define __TOP_SV__

module top ();

    string status;
    int delay;

    initial begin
        $timeformat(-9, 2, " s");
        
        $display("TEST START TIME: %0g", $realtime);

        void'($value$plusargs("STATUS=%s", status));        
    
        case (status)
            "PASS": $display("Test: PASS");
            "FAIL": $display("Test: FAIL");
            "FATAL": $display("Test: FATAL");
            default:  $display("Test: UNKNOWN");
        endcase

        delay = $urandom_range(30, 10);
        
        #(1s*delay) $display("TEST FINISH TIME: %0g", $realtime);
    end

    
endmodule: top

`endif // __TOP_SV__
