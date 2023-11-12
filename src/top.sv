`ifndef __TOP_SV__
`define __TOP_SV__

module top ();

    string status;

    initial begin

        void'($value$plusargs("STATUS=%s", status));        
    
        case (status)
            "PASS": $display("Test: PASS");
            "ERROR": $display("Test: ERROR");
            "FATAL": $display("Test: FATAL");
            default:  $display("Test: UNKNOWN");
        endcase

    end
    
endmodule: top

`endif // __TOP_SV__
