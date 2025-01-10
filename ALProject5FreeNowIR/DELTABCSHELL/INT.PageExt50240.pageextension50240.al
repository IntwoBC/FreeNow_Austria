pageextension 50240 pageextension50240 extends "Cost Adjustment Detailed Logs"
{

    //Unsupported feature: Property Modification (TextConstString) on "ConfirmBlankPasswordQst(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //ConfirmBlankPasswordQst : ENU=Do you want to exit without entering a password?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ConfirmBlankPasswordQst : ENU=Do you want to exit the dialog box with an empty password?;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValidPassword := false;
    if CloseAction = ACTION::OK then begin
      if RequiresPasswordConfirmation and (SetPassword <> ConfirmPassword) then
        Error(PasswordMismatchErr);
      if EnableBlankPasswordState and (SetPassword = '') then begin
        if not Confirm(ConfirmBlankPasswordQst) then
          Error(PasswordTooSimpleErr);
      end else begin
        if SetPassword = '' then
          Error(PasswordBlankIsNotAllowedErr);
        if ValidatePassword and not IdentityManagement.ValidatePasswordStrength(SetPassword) then
          Error(PasswordTooSimpleErr);
      end;
      ValidPassword := true;
    end
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    #11..15
    */
    //end;
}

