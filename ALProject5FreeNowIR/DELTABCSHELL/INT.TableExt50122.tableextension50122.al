tableextension 50122 tableextension50122 extends "VAT Registration Log"
{

    //Unsupported feature: Code Modification on "GetCountryCode(PROCEDURE 2)".

    //procedure GetCountryCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Country/Region Code" = '' then begin
      if not CompanyInformation.Get then
        exit('');
      exit(CompanyInformation."Country/Region Code");
    end;
    CountryRegion.Get("Country/Region Code");
    if CountryRegion."EU Country/Region Code" = '' then
      exit("Country/Region Code");
    exit(CountryRegion."EU Country/Region Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    exit("Country/Region Code");
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "GetCountryCode(PROCEDURE 2).CountryRegion(Variable 1001)".

}

