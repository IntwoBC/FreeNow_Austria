codeunit 60999 "Prepare EY Database"
{

    trigger OnRun()
    begin
    end;

    var
        txtConfirm: Label 'Are you sure you want to initialise the database?';
        txtBlue: Label 'Blue.bmp';
        txtYellow: Label 'Yellow.bmp';
        txtRed: Label 'Red.bmp';
        txtGreen: Label 'Green.bmp';
        txtCountryRapidstart: Label 'PackageEY-COUNTRY-SERVICES-NAV2016.rapidstart';
        txtGlobalRapidstart: Label 'PackageEY-GLOBAL-SERVICES-NAV2016.rapidstart';
        txtMAINProfileID: Label 'EY-COE-MAIN';
        txtMAINProfileDesc: Label 'EY Center of Excellence Main';
        txtCountryProfileID: Label 'EY-COUNTRY-MAIN';
        txtCountryProfileDesc: Label 'EY Country Services';
        txtEYCorePermSetFile: Label 'EYCorePermissionSets.txt';
        txtEYCorePermFile: Label 'EYCorePermissions.txt';

    //[Scope('Internal')]
    procedure gfcnInitDB(ptxtWorkFolder: Text)
    var
        lrecStatusColor: Record "Status Color";
        lrecGlobalFileStorage: Record "Global File Storage";
        //ltmpTempBlob: Record TempBlob temporary;
        lrecEYCoreSetup: Record "EY Core Setup";
        //lrecProfile: Record "Profile";
        lmdlFileMgt: Codeunit "File Management";
        lfilFile: File;
        listFile: InStream;
    begin
        if GuiAllowed then
            if not Confirm(txtConfirm) then
                exit;

        lrecEYCoreSetup.Insert;
        /*
                with lrecStatusColor do begin
                    Status := Status::Imported;
                    Picture.Import(ptxtWorkFolder + txtBlue);
                    Insert;

                    Status := Status::"In Progress";
                    Picture.Import(ptxtWorkFolder + txtYellow);
                    Insert;

                    Status := Status::Error;
                    Picture.Import(ptxtWorkFolder + txtRed);
                    Insert;

                    Status := Status::Processed;
                    Picture.Import(ptxtWorkFolder + txtGreen);
                    Insert;
                end;

                with lrecGlobalFileStorage do begin
                    Type := Type::"RapidStart-CountryServices";
                    "File Name" := txtCountryRapidstart;
                    lmdlFileMgt.BLOBImportFromServerFile(ltmpTempBlob, ptxtWorkFolder + "File Name");
                    Blob := ltmpTempBlob.Blob;
                    Insert(true);

                    Type := Type::"RapidStart-GlobalServices";
                    "File Name" := txtGlobalRapidstart;
                    ltmpTempBlob.Init;
                    lmdlFileMgt.BLOBImportFromServerFile(ltmpTempBlob, ptxtWorkFolder + "File Name");
                    Blob := ltmpTempBlob.Blob;
                    Insert(true);
                end;

                with lrecProfile do begin
                    "Profile ID" := txtMAINProfileID;
                    Description := txtMAINProfileDesc;
                    "Role Center ID" := 60000;
                    Insert(true);

                    Init;
                    "Profile ID" := txtCountryProfileID;
                    Description := txtCountryProfileDesc;
                    "Role Center ID" := 60091;
                    Insert(true);

                    SetRange("Default Role Center", true);
                    if FindFirst then begin
                        "Default Role Center" := false;
                        Modify;
                    end;
                end;
        
        // Import Permission Sets
        lfilFile.Open(ptxtWorkFolder + txtEYCorePermSetFile);
        lfilFile.CreateInStream(listFile);
        XMLPORT.Import(XMLPORT::"Import/Export Permission Sets", listFile);
        lfilFile.Close;

        lfilFile.Open(ptxtWorkFolder + txtEYCorePermFile);
        lfilFile.CreateInStream(listFile);
        XMLPORT.Import(XMLPORT::"Import/Export Permissions", listFile);
        lfilFile.Close;
        */
    end;
}

