tableextension 50187 tableextension50187 extends "Prod. Order Routing Line"
{

    //Unsupported feature: Code Modification on "MachineCtrTransferFields(PROCEDURE 1)".

    //procedure MachineCtrTransferFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WorkCenter.Get(MachineCenter."Work Center No.");
    WorkCenterTransferFields;

    #4..9
    "Minimum Process Time" := MachineCenter."Minimum Process Time";
    "Maximum Process Time" := MachineCenter."Maximum Process Time";
    "Concurrent Capacities" := MachineCenter."Concurrent Capacities";
    if "Concurrent Capacities" = 0 then
      "Concurrent Capacities" := 1;
    "Send-Ahead Quantity" := MachineCenter."Send-Ahead Quantity";
    "Setup Time Unit of Meas. Code" := MachineCenter."Setup Time Unit of Meas. Code";
    "Wait Time Unit of Meas. Code" := MachineCenter."Wait Time Unit of Meas. Code";
    #18..22
    "Overhead Rate" := MachineCenter."Overhead Rate";
    FillDefaultLocationAndBins;
    OnAfterMachineCtrTransferFields(Rec,WorkCenter,MachineCenter);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    #15..25
    */
    //end;
}

